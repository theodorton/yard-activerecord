# YARD ActiveRecord Plugin

[![Version](http://img.shields.io/gem/v/yard-activerecord.svg?style=flat-square)](https://rubygems.org/gems/yard-activerecord)
[![Downloads](http://img.shields.io/gem/dt/yard-activerecord.svg?style=flat-square)](https://rubygems.org/gems/yard-activerecord)
[![Open Github issues](http://img.shields.io/github/issues/theodorton/yard-activerecord.svg?style=flat-square)](https://github.com/theodorton/yard-activerecord/issues)

A YARD extension that handles and interprets methods used when developing
applications with ActiveRecord. The extension handles attributes,
associations, delegates and scopes. A must for any Rails app using YARD as
documentation plugin.

## Installation

Run the following command in order to load YARD plugins:

```
$ yard config load_plugins true
```

## Attributes

In order for this plugin to document any database attributes you need to add
`schema.rb` to your list of files. This is preferably done with in `.yardopts`
within your app project folder:

```
# .yardopts
'app/**/*.rb'
'db/schema.rb'
```

It's important that the `schema.rb`-file is added at the end as it needs all
classes loaded before it can add the attributes.

The plugin will then document all attributes in your documentation.

All attributes will be marked as writable. I will update the plugin to include
handling of `attr_accessible` at a later point.

Please note that any reference-fields that ends with `_id` will not be handled
as an attribute. Please see Associations.

## Associations

The plugin handles `has_one`, `belongs_to`, `has_many` and
`has_and_belongs_to_many` associations. The annotation for each association
includes a link to the referred model. For associations with a list of objects
the documentation will simply be marked as `ActiveRecord::Relation<ModelName>`.

## Delegates

The plugin handles `delegate`-methods and marks these delegated instance
methods simply as aliases for the associated object.

## Scopes

The plugin will add class methods for any scopes you have defined in your
models.

## Validations

The plugin will add information about validations onto each field. It only handles
the new style validations in the form of:

    validates :foo, :presence=>true, :length=>{ is: 6 }

Validations in the older form of:

    validates_presence_of :foo

are not supported.

## Other useful plugins

Check out:

- [https://github.com/ogeidix/yard-rails-plugin](https://github.com/ogeidix/yard-rails-plugin)
