# todo_test.rb

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
      puts "TypeError: Can only add Todo objects"
    end
  end

end

todo1 = Todo.new("Buy milk")
list = TodoList.new("My List")

list.add(5)