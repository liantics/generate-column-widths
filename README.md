# Generate::Column::Widths

This gem allows you to calculate the number of columns to span in a css grid
when your site may have a variable number of columns of data to display.

It allows you to generate the number of columns you need, and to have them
automatically be the correct widths to fit your page, based on the data you have
to display. You don't need to know a priori how many columns your data will
produce, and you don't need to fill your html with a bunch of centering divs to
try to make it look ok.

It also allows you to accommodate a situation when the columns being generated
need to fit alongside columns that are already on the page.

## Installation

Add this line to your application's Gemfile:

    gem 'generate-column-widths'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install generate-column-widths

## Usage
Once it's installed, it's easy to use:

###1. Include the Module in the Model that Needs It

In the model whose views will need auto-generated column widths:

    include GenerateColumnWidths

#### Example
Since I'm using this for views that contain lists of project categories, I put
it in my Category model, category.rb:

    class Category < ActiveRecord::Base
      include GenerateColumnWidths
      ...
    end

###2. Determine How Many Columns are in Your Data
In the controller where the view is generated, calculate the number of columns
you need. This is based entirely on the data in your database, and what you're
trying to display.

####Example:
In my case, I needed to get a count of the number of meta-category headings I'd
have in my view by finding out how many of those meta-categories contained any
associated projects:

    @category_types = # determine which categories contain projects
    @category_types_count = category_types.count

###3. Call the Generator
The simplest call is to call the generate_widths method with your new
variable. Call it via the model into which you placed it. In my case, that's Category.

"generate_widths" is the name of the method inside the GenerateColumnWidths
module.

    @column_width = Category.new.generate_widths(
      @category_types_count
    )

###You can Change the Defaults
The generator has several defaults built in. It assumes you want a maximum of 4
columns in your view, using a 12 column Bootstrap 3 grid. You can change the
defaults by specifying a different value for any or all of the optional variables.

####Option: total_grid_columns
The number of columns in your grid system. Bootstrap 3 uses 12, others may use 9
or some other number.

Default:
    total_grid_columns: 12

####Option: existing_columns
The number of columns already in the view, that will share a row with your new
columns. In the vast majority of cases, you won't need to change this, but it's
here in case you do.

Default:
    existing_columns: 0

####Option: min_column_span
The minimum span you want to use. This is one of those counter-intuitive things
in Bootstrap. It's not the number of columns you want, it's the number from the
12 columns in the grid that you want this column to span. So, you divide the
total number of columns in the grid by this number to get the number of columns
you're trying to span. The result is how many columns you'll end up with in your
row, before Bootstrap wraps to a new line to display the next set of columns.

The default is to span 3 columns, at a minimum, which means (12 / 3 = 4) you'll
get a maximum of 4 columns in the view.

Default:
    min_column_span: 3

####Option: max_column_span
This is the maximum number of columns you want to span. It's the opposite of the
above. The default is 12, so divide 12/12, and you get ... 1. That's the minimum
number of columns that will be shown.

Default:
    max_column_span: 12

####Example
On one page, I need to accomodate an extra column of data that's generated
elsewhere. So my categories columns will appear in the same row as an extra
column. To deal with this, I can call:

    @column_width = Category.new.generate_widths(
      @category_types_count,
      existing_columns: 1
    )

If I were using a 9 grid, instead of a 12 grid, I could specify:

    @column_width = Category.new.generate_widths(
      @category_types_coune,
      total_grid_columns: 9
      max_column_span: 9
    )

In this case, the default min_column_span (3) would be divided into 9, giving me a
maximum of 3 columns in my view before Bootstrap wraps to a new line for
additional columns.

###5. Use it in Your View
Here's what it looks like in a Bootstrap column for small views and higher:

    <% @category_types.each do |type| %>
      <div class="col-sm-<%= @column_width %>">
      ...
    <% end %>

## Contributing

1. Fork it ( https://github.com/[my-github-username]/generate-column-widths/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
