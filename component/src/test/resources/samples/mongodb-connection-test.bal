import ballerina.data.mongodb;

const string cassandraHost = "127.0.0.1";

function testConnectorInitWithDirectUrl() (json) {
    endpoint<mongodb:ClientConnector> conn {
                    create mongodb:ClientConnector("", "studentdb",  "", "", {url:
                    "mongodb://" + cassandraHost + ":27017/?sslEnabled=false&serverSelectionTimeout=500"});
        }
    json query = {"name":"Jim", "age":"21"};
    json result = conn.find("students", query);
    conn.close();
    return result;
}

function testConnectorInitWithConnectionPoolProperties() (json) {
    endpoint<mongodb:ClientConnector> conn {
                    create mongodb:ClientConnector(cassandraHost, "studentdb",  "", "", {sslEnabled: false,
                    serverSelectionTimeout: 500, maxPoolSize: 1, maxIdleTime: 60000, maxLifeTime: 1800000,
                    minPoolSize: 1, waitQueueMultiple: 1, waitQueueTimeout: 150 });
        }
    json query = {"name":"Jim", "age":"21"};
    json result = conn.find("students", query);
    conn.close();
    return result;
}

function testConnectorInitWithInvalidAuthMechanism() {
    endpoint<mongodb:ClientConnector> conn {
                    create mongodb:ClientConnector(cassandraHost, "studentdb",  "", "", {sslEnabled: false,
                    serverSelectionTimeout: 500, authMechanism: "invalid-auth-mechanism" });
        }
}