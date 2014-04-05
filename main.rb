$infected = [:method_added]

class Class
  def method_added(method_name)
    old_method = "old_#{method_name}".to_sym
    virus = -> { puts "#{method_name} called in infected #{self}"; send(old_method) }

    unless $infected.include? method_name
      $infected << method_name
      $infected << old_method

      self.send(:alias_method, old_method, method_name)
      self.send(:define_method, method_name, virus)
    end
  end
end

class Module
  def method_added(method_name)
    old_method = "old_#{method_name}".to_sym
    virus = -> { puts "#{method_name} called in infected #{self}"; send(old_method) }

    unless $infected.include? method_name
      $infected << method_name
      $infected << old_method

      self.send(:alias_method, old_method, method_name)
      self.send(:define_method, method_name, virus)
    end
  end
end

module Bar
  def hello
    puts "Hello"
  end
end

class Foo
  include Bar
end

f = Foo.new
f.hello
