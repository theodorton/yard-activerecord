# YARD ActiveRecord Plugin #

A YARD extension that handles and interprets methods used when developing
applications with ActiveRecord. The extension handles attributes,
associations, delegates and scopes. A must for any Rails app using YARD as
documentation plugin.

The plugin handles the following:

*  Attributes
*  Associations
*  Scopes

## Attributes ##

In order for this plugin to document any database attributes you need to add
`schema.rb` to your list of files. This is preferably done with in `.yardopts`.

The `schema.rb`-file should be added at the end as it needs all classes loaded
before it can add the attributes.

The plugin will then document all attributes in your documentation.

All attributes will be marked as writable. I will update the plugin to include
handling of `attr_accessible` at a later point.

Please note that any reference-fields that ends with `_id` will not be handled
as an attribute. Please see Associations.

There is an issue with namespaced classes. Currently this plugin will try and
fetch a class with a namespace if it does not find one at the first try.

Example:

    Table name        Class name
    sales_people      SalesPeople # does not exist
    sales_people      Sales::People # does exist

A problem then emerges if you have namespaces with two names.

Example:

    Table name          Class name
    sales_force_people  SalesForcePeople # does not exist
    sales_force_people  Sales::ForcePeople # does not exist

The documentation will then be skipped for this table/class.

## Associations ##

The plugin handles `has_one`, `belongs_to`, `has_many` and
`has_and_belongs_to_many` associations. The annotation for each association
includes a link to the referred model. For associations with a list of objects
the documentation will simply be marked as `Array<ModelName>`.

## Scopes ##

The plugin will add class methods for any scopes you have defined in your
models.

