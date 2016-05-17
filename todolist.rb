# todolist.rb

require 'pry'

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo_item)
    if todo_item.instance_of? Todo
      @todos << todo_item 
    else
      raise(TypeError, "Can only add Todo objects")
    end
  end

  #def <<(todo_item)
    #self.add(todo_item)
  #end

  def item_at(index)
    @todos[index]
  end

  def mark_done_at(index)
    if index < @todos.length
      @todos[index].done!
    else
      raise(IndexError, "That index does not exist")
    end
  end

  def mark_undone_at(index)
    if index < @todos.length
      @todos[index].undone!
    else
      raise(IndexError, "That index does not exist")
    end
  end

  def size
    @todos.length
  end

  def first
    @todos[0]
  end

  def last
    @todos[-1]
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    if index < @todos.length
      @todos.delete_at(index)
    else
      raise(IndexError, "That index does not exist")
    end
  end

  def to_s
    @todos.each do |x|
      puts x
    end
  end

  def each
    counter = 0
    while counter < self.size
      yield(self.item_at(counter))
      counter += 1
    end
    self
  end

  def select
    select_list = TodoList.new("#{self.title} select list")

    self.each do |x|
      select_list.add(x) if yield(x)
    end
    select_list
  end

  def find_by_title(title)
    self.select {|x| return x if x.title == title}.first
  end

  def all_done
    done_list = self.select {|x| x.done?}
    done_list.title = "#{self.title} done items"
    done_list
  end

  def all_not_done
    not_done_list = self.select {|x| !x.done?}
    not_done_list.title = "#{self.title} not done items"
    not_done_list
  end

  def mark_done(title)
    find_by_title(title) && find_by_title(title).done!
  end

  def mark_all_done
    each {|x| x.done!}
  end

  def mark_all_undone
    each {|x| x.undone!}
  end
end

system "clear"


# given
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
todo4 = Todo.new("Rock out")
todo5 = Todo.new("Rule the world")
list = TodoList.new("Today's Todos")

# ---- Adding to the list -----

# add
list.add(todo1)                 # adds todo1 to end of list, returns list
list.add(todo2)                 # adds todo2 to end of list, returns list
list.add(todo3)
list.add(todo4)
list.add(todo5)                 # adds todo3 to end of list, returns list
# list.add(1)                     # raises TypeError with message "Can only add Todo objects"

list.mark_done_at(1)
list.mark_done_at(3)

binding.pry

list.mark_done("Become a ninja")

## <<
## same behavior as add
#
## ---- Interrogating the list -----
#
## size
#list.size                       # returns 3
#
## first
#list.first                      # returns todo1, which is the first item in the list
#
## last
#list.last                       # returns todo3, which is the last item in the list
#
## ---- Retrieving an item in the list ----
#
## item_at
## list.item_at                    # raises ArgumentError
#list.item_at(1)                 # returns 2nd item in list (zero based index)
#list.item_at(100)               # raises IndexError
#
## ---- Marking items in the list -----
#
## mark_done_at
## list.mark_done_at               # raises ArgumentError
#list.mark_done_at(1)            # marks the 2nd item as done
## list.mark_done_at(100)          # raises IndexError
#
## mark_undone_at
## list.mark_undone_at             # raises ArgumentError
#list.mark_undone_at(1)          # marks the 2nd item as not done,
## list.mark_undone_at(100)        # raises IndexError
#
## ---- Deleting from the the list -----
#
## shift
## list.shift                      # removes and returns the first item in list
#
## pop
## list.pop                        # removes and returns the last item in list
#
## remove_at
## list.remove_at                  # raises ArgumentError
## list.remove_at(1)               # removes and returns the 2nd item
## list.remove_at(100)             # raises IndexError
#
## ---- Outputting the list -----
#
## to_s
#list.to_s                      # returns string representation of the list
#
## ---- Today's Todos ----
## [ ] Buy milk
## [ ] Clean room
## [ ] Go to gym
#
## or, if any todos are done
#
## ---- Today's Todos ----
## [ ] Buy milk
## [X] Clean room
## [ ] Go to gym