const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "codelist": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://jatcwhhyrvfr5a4tsqk3gcjwqm.appsync-api.us-east-1.amazonaws.com/graphql",
                    "region": "us-east-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-zdma5hneknaoxosksmxlkgcvaa"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://jatcwhhyrvfr5a4tsqk3gcjwqm.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-zdma5hneknaoxosksmxlkgcvaa",
                        "ClientDatabasePrefix": "codelist_API_KEY"
                    }
                }
            }
        }
    }
}''';