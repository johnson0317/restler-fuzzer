# Compiling the API Specification

RESTler analyzes the Swagger/OpenAPI spec and generates a fuzzing grammar, which contains information about parameters and responses for individual requests and the dependencies between requests.

- To quickly generate the RESTler grammar and templates for other artifacts required for fuzzing, run:

  ```restler.exe compile --api_spec <full path to API specification>```

- For medium to large services, further configuration will likely be required.  To quickly generate the RESTler config files that you will most likely need to provide, run:

  ```restler.exe generate_config --specs <full path to API specification>```

This step will generate a `restlerConfig` directory that contains several files.  The compiler config file (`config.json`) is used to compile the API spec with the full set of configuration options.  The `dict.json` file is where you may provide specific constants required by your service (for example, a required header value that specifies the `api-version`).  The `annotations.json` file specify dependencies between requests.  The `engine_settings.json` file specifies general settings for the fuzzing run.

- To compile the API spec with the full set of configuration options, run:

  ```restler.exe compile <path to config.json>```

*Warning*: run RESTler in a directory where you have write access because RESTler will create a sub-directory to generate the outputs.

**Outputs:**

* See the sub-directory Compile

* RESTler will generate new files `grammar.py`, `grammar.json`, `dict.json`, and logs from the compiler in this sub-directory.  A brief diagnostic will be given in the console.

The following describes all available inputs and configuration options for the compiler.

### Required inputs

1. A Swagger/OpenAPI specification in JSON or YAML format.

   Several specifications may be included, and the grammar will be a union of all specifications.

2. A RESTler configuration file in JSON format.

An example may be generated by running the ```restler.exe compile --api_spec ...``` command above.

The compiler configuration is described in detail in [Compiler Config](CompilerConfig.md).

3. A RESTler fuzzing dictionary in JSON format.

The dictionary format is described in detail in [Fuzzing Dictionary](FuzzingDictionary.md).  An example dictionary is also generated by the quick start command above.

### Optional inputs

1. Examples.

   Examples may be specified to improve coverage.  They are specified either inline (e.g. already included in the specification), or in a separate file.  In the latter case, a json file specifying which endpoints and method the examples correspond to must be provided.

   For more information, see [Examples](Examples.md).

2. Engine settings.  When specified, the inferred per-resource timing delays will be added into the existing settings, and a new file will be written to the compiler output directory.  See [Settings File](SettingsFile.md).

## How to invoke RESTler in compile mode

`C:\RESTler\restler\Restler.exe compile <RESTler configuration file>`

Example: see [Tutorial](TutorialDemoServer.md)

*Warning*: run RESTler in a directory where you have write access because RESTler will generate there new results files and directories!

Outputs:

* See the sub-directory Compile

* RESTler will generate new files `grammar.py`, `grammar.json`, `dict.json`, and logs from the compiler in this sub-directory.  A brief diagnostic will be given in the console.

If producer-consumer dependencies are unresolved in the Swagger specification, the user can either ignore those or can annotate the Swagger JSON or YAML specification to help RESTler resolve those.  See [Annotations](Annotations.md).

