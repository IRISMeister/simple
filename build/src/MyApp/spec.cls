Class MyApp.spec Extends %REST.Spec [ ProcedureBlock ]
{

XData OpenAPI [ MimeType = application/json ]
{
{
  "info":{
    "title":"myapp",
    "description":"very simple api",
    "version":"0.1"
  },
  "schemes":[
    "http"
  ],
  "basePath":"/csp/myapp",
  "paths":{
    "/get":{
      "get":{
        "summary":"Get current info",
        "operationId":"Get",
        "responses":{
          "200":{
            "description":"successful operation",
            "schema":{
              "$ref":"#/definitions/result"
            },
            "examples":{
              "application/json":{
                "HostName":"myiris",
                "UserName":"appuser",
                "Status":"OK",
                "TimeStamp":"09/30/2019 14:51:18"
              }
            }
          },
          "401":{
            "description":"Unauthorized User"
          }
        }
      }
    },
    "/history":{
      "get":{
        "summary":"Get history",
        "operationId":"History",
        "responses":{
          "200":{
            "description":"(Expected Result)",
            "schema":{
              "type":"array",
              "items":{
                "$ref":"#/definitions/result"
              }
            }
          }
        }
      }
    }
  },
  "definitions":{
    "result":{
      "type":"object",
      "properties":{
        "HostName":{
          "type":"string"
        },
        "UserName":{
          "type":"string"
        },
        "Status":{
          "type":"string",
          "enum":[
            "OK",
            "NG"
          ]
        },
        "TimeStamp":{
          "type":"string",
          "format":"date-time"
        }
      }
    }
  },
  "securityDefinitions":{
    "basicAuth":{
      "type":"basic"
    }
  },
  "security":[
    {
      "basicAuth":[
      ]
    }
  ],
  "swagger":"2.0"
}
}

}
