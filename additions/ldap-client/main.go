package main

import (
	"crypto/rand"
	"encoding/hex"
	"flag"
	"fmt"
	"log"
	"time"

	"github.com/go-ldap/ldap/v3"
)

func main() {
	// Define command-line flags
	server := flag.String("server", "127.0.0.1", "LDAP server address")
	port := flag.Int("port", 389, "LDAP server port")
	username := flag.String("username", "cn=admin,dc=example,dc=com", "Bind username")
	password := flag.String("password", "admin", "Bind password")
	baseDN := flag.String("baseDN", "dc=example,dc=com", "Base DN for operations")
	useTLS := flag.Bool("tls", false, "Use TLS for connection (LDAPS)")

	// Parse the flags
	flag.Parse()

	// Validate required flags
	if *username == "" || *password == "" {
		log.Fatal("Both username and password must be provided.")
	}

	// Build the LDAP URL
	protocol := "ldap"
	if *useTLS {
		protocol = "ldaps"
	}
	ldapURL := fmt.Sprintf("%s://%s:%d", protocol, *server, *port)

	for {
		// Wait for 5 seconds before the next cycle
		time.Sleep(5 * time.Second)

		log.Println("---")
		log.Println("Starting LDAP operation cycle...")

		// Dial the LDAP server
		conn, err := ldap.DialURL(ldapURL)
		if err != nil {
			log.Printf("Failed to dial LDAP server: %v url: %s\n", err, ldapURL)
			continue
		}
		log.Printf("Successfully connected to LDAP server at: %s\n", ldapURL)

		// Perform the bind operation
		controls := []ldap.Control{}
		controls = append(controls, ldap.NewControlBeheraPasswordPolicy())
		bindRequest := ldap.NewSimpleBindRequest(*username, *password, controls)
		result, err := conn.SimpleBind(bindRequest)
		if err != nil {
			log.Printf("Failed to bind to LDAP server: %v username: %s password: %s\n", err, *username, *password)
			continue
		}
		log.Printf("Successfully authenticated to the LDAP server. username: %s password: %s\n", *username, *password)

		// Password policy
		ppolicyControl := ldap.FindControl(result.Controls, ldap.ControlTypeBeheraPasswordPolicy)
		var ppolicy *ldap.ControlBeheraPasswordPolicy
		if ppolicyControl != nil {
			ppolicy = ppolicyControl.(*ldap.ControlBeheraPasswordPolicy)
			if ppolicy != nil {
				if ppolicy.Expire >= 0 {
					log.Printf("Password expires in %d seconds\n", ppolicy.Expire)
				} else if ppolicy.Grace >= 0 {
					log.Printf("Password expired, %d grace logins remain\n", ppolicy.Grace)
				}
			}
		} else {
			log.Printf("ppolicyControl response not available.\n")
		}

		// Generate a random username
		randomUsername := fmt.Sprintf("john_%s", generateRandomString(8))
		userDN := fmt.Sprintf("cn=%s,%s", randomUsername, *baseDN)

		// Create a new user
		addRequest := ldap.NewAddRequest(userDN, nil)
		addRequest.Attribute("objectClass", []string{"inetOrgPerson"})
		addRequest.Attribute("cn", []string{randomUsername})
		addRequest.Attribute("sn", []string{"Test"})
		addRequest.Attribute("userPassword", []string{"password123"})
		err = conn.Add(addRequest)
		if err != nil {
			log.Printf("Failed to create a user %s: %v\n", randomUsername, err)
			continue
		}
		log.Printf("User %s created successfully.\n", randomUsername)

		// Modify the user
		modifyRequest := ldap.NewModifyRequest(userDN, nil)
		modifyRequest.Add("description", []string{"An example user"})
		modifyRequest.Replace("mail", []string{"user@example.org"})
		err = conn.Modify(modifyRequest)
		if err != nil {
			log.Printf("Failed to modify the user %s: %v\n", randomUsername, err)
			continue
		}
		log.Printf("User %s modified successfully.\n", randomUsername)

		// Search the user
		searchReq := ldap.NewSearchRequest(
			userDN,
			ldap.ScopeWholeSubtree,
			0,
			0,
			0,
			false,
			fmt.Sprintf("(CN=%s)", ldap.EscapeFilter(randomUsername)),
			[]string{
				"sAMAccountName",
				"objectClass",
				"sn",
				"userPassword",
			},
			[]ldap.Control{},
		)
		searchResult, err := conn.Search(searchReq)
		if err != nil {
			log.Printf("Failed to search the user %s: %v\n", randomUsername, err)
			continue
		}
		log.Printf(
			"User %s search results: %+v\n",
			randomUsername,
			searchResult.Entries[0],
		)
		log.Printf(
			"User %s searched attributes: %s:%+v %s:%+v %s:%+v\n",
			randomUsername,
			searchResult.Entries[0].Attributes[0].Name,
			searchResult.Entries[0].Attributes[0].Values,
			searchResult.Entries[0].Attributes[1].Name,
			searchResult.Entries[0].Attributes[1].Values,
			searchResult.Entries[0].Attributes[2].Name,
			searchResult.Entries[0].Attributes[2].Values,
		)

		// Delete the user
		delRequest := ldap.NewDelRequest(userDN, nil)
		err = conn.Del(delRequest)
		if err != nil {
			log.Printf("Failed to delete the user %s: %v\n", randomUsername, err)
			continue
		}
		log.Printf("User %s deleted successfully.\n", randomUsername)

		// Unbind from the LDAP server
		err = conn.Unbind()
		if err != nil {
			log.Printf("Failed to unbind: %v\n", err)
			continue
		}
		log.Println("Unbound from LDAP server.")

		// Close the connection
		err = conn.Close()
		if err != nil {
			log.Printf("Failed to close connection: %v\n", err)
			continue
		}
		log.Println("Closed connection to LDAP server.")
	}
}

// generateRandomString generates a random string of the given length.
func generateRandomString(length int) string {
	bytes := make([]byte, length)
	_, err := rand.Read(bytes)
	if err != nil {
		log.Fatalf("Failed to generate random string: %v", err)
	}
	return hex.EncodeToString(bytes)[:length]
}
