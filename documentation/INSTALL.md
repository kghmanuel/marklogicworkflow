

## Configure MIME types

Default filenames for SCXML and BPMN2 bodels are .scxml and .bpmn respectively. These aren't recognised by MarkLogic
by default. Add these types are application/xml mime types in MarkLogic Server for them to be handled correctly.

## Configuring a database for MarkLogic Workflow

You can install a MarkLogic Workflow modules database from the modules folder within this repository. Once done,
your application's app server can be configured to either use this modules database, or more likely, use a modules
database whose modules database points to this database (modules database chaining).

You can also optionally install the REST extensions and search options in the rest-api folder of this repository
to allow external applications to integrate to MarkLogic Workflow. Install these extensions in your app server. The
correct triggers and modules databases will be automatically determined by the MarkLogic Workflow code
with no extra work from yourself.

You need to ensure your content database has a Triggers database configured, and that CPF is enabled
(with NO global domain) before you try and deploy a process model in MarkLogic Workflow.

## Configure global process task settings

Some tasks require global configuration. An example of this is the email task which requires SMTP settings.

TODO: Provide a standard way to support this.
