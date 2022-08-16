
# Changes in Keycloak config needed for direct access to test with the scripts

## Client -> secvisogram -> Settings

Direct Access Grants Enabled  ON
OAuth 2.0 Device Authorization Grant Enabled ON
Authentication Flow Overrides -> Direct Grant Flow = Direct Grant

## Client -> secvisogram -> Mappers -> client roles

Change values to
Add to ID token			ON
Add to access token		ON
Add to userinfo			ON
