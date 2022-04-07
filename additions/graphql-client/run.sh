#!/bin/bash

GRAPHQL_SERVER=http://mizutest-graphql-server:8080/

while true
do

curl -X POST $GRAPHQL_SERVER \
    --silent \
    --output /dev/null \
    -H "Content-Type: application/json" \
    -d @- <<BODY
{"query": "
{
  person(personID: 4) {
    name
  }
}
"}
BODY

curl -X POST $GRAPHQL_SERVER \
    --silent \
    --output /dev/null \
    -H "Content-Type: application/json" \
    -d @- <<BODY
{"query": "
{
  person(personID: 4) {
    name
    gender
    homeworld {
      name
    }
  }
}
"}
BODY

curl -X POST $GRAPHQL_SERVER \
    --silent \
    --output /dev/null \
    -H "Content-Type: application/json" \
    -d @- <<BODY
{"query": "
{
  person(personID: 4) {
    name
    gender
    homeworld {
      name
    }
    starshipConnection {
      edges {
        node {
          id
          manufacturers
        }
      }
    }
  }
}
"}
BODY

curl -X POST $GRAPHQL_SERVER \
    --silent \
    --output /dev/null \
    -H "Content-Type: application/json" \
    -d @- <<BODY
{"query": "
# GraphQL server handles pagination on this example
{
  allStarships {
    edges {
      node {
        id
      }
    }
  }
}
"}
BODY

curl -X POST $GRAPHQL_SERVER \
    --silent \
    --output /dev/null \
    -H "Content-Type: application/json" \
    -d @- <<BODY
{"query": "
{
  allStarships(first: 7) {
    edges {
      node {
        id
        name
        model
        costInCredits
        pilotConnection {
          edges {
            node {
              name 
              homeworld {
                name
              }               
            }
          }
        }
      }
    }
  }
}
"}
BODY

curl -X POST $GRAPHQL_SERVER \
    --silent \
    --output /dev/null \
    -H "Content-Type: application/json" \
    -d @- <<BODY
{"query": "
{
  allStarships(first: 7) {
    edges {
      node {
        id
        name
        model
        costInCredits
        pilotConnection {
          edges {
            node {
              ...pilotFragment
            }
          }
        }
      }
    }
  }
}

fragment pilotFragment on Person {
  name
  homeworld { name }
}
"}
BODY

curl -X POST $GRAPHQL_SERVER \
    --silent \
    --output /dev/null \
    -H "Content-Type: application/json" \
    -d @- <<BODY
{"query": "
{
  allStarships(first: 7) {
    edges {
      node {
        ...starshipFragment
      }
    }
  }
}

fragment starshipFragment on Starship {
  id
  name
  model 
  costInCredits
  pilotConnection { edges { node { ...pilotFragment }}}
}
fragment pilotFragment on Person {
  name
  homeworld { name }
}
"}
BODY

curl -X POST $GRAPHQL_SERVER \
    --silent \
    --output /dev/null \
    -H "Content-Type: application/json" \
    -d @- <<BODY
{"query": "
{
  __type(name: \"Person\") {
    name 
    fields {
      name 
      description
      type { name }
    }
  }
}
"}
BODY

    sleep 3
done
