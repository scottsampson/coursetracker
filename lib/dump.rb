module Dump 
  @standard_objects = ["Integer","String","Float","Rational","Complex","Fixnum","Bignum","Time"]
  
  def self.var(str,a,depth = 0)
    RAILS_DEFAULT_LOGGER.info c("Begin #{str}")
    parse_var(a,depth = 0)
    RAILS_DEFAULT_LOGGER.info c("end #{str}")
  end
  
  def self.parse_var(a,depth = 0)
    depth += 1
    #RAILS_DEFAULT_LOGGER.info c("class -- #{a.class.to_s}")
    if(a.class.to_s == "Array") 
      a.each_with_index {|x,y| 
        spaces = ""
        for i in 0...depth
         spaces << "    "
        end
        if @standard_objects.include?(x.class.to_s)
          RAILS_DEFAULT_LOGGER.info c("#{spaces}#{y} => #{x}")
        else
          RAILS_DEFAULT_LOGGER.info c("#{spaces}#{y} => #{x.class.to_s}")
          parse_var(x,depth)
        end 
      } # iterate over the contents
    elsif ['Hash','HashWithIndifferentAccess'].include?(a.class.to_s)
      a.each {|x,y| 
        spaces = ""
        for i in 0...depth
         spaces << "    "
        end
      
        if @standard_objects.include?(y.class.to_s)
          RAILS_DEFAULT_LOGGER.info c("#{spaces}#{x} => #{y}")
        else
          RAILS_DEFAULT_LOGGER.info c("#{spaces}#{x} => #{y.class.to_s}")
          parse_var(y,depth)
        end
      } # iterate over the contents
    elsif @standard_objects.include?(a.class.to_s)
      spaces = ""
      for i in 0...depth
       spaces << "    "
      end
      RAILS_DEFAULT_LOGGER.info c("#{spaces}#{a} -  #{a.class.to_s}")
    else 
      #object
      a.instance_variables.each { |var|
        spaces = ""
        for i in 0...depth
         spaces << "    "
        end
        val = a.methods.include?(var[1..var.length]) ? a.send(var[1..var.length]) : "no getter"
        if @standard_objects.include?(val.class.to_s)
          RAILS_DEFAULT_LOGGER.info c("#{spaces}#{var} => #{val}")
        else
          RAILS_DEFAULT_LOGGER.info c("#{spaces}#{var} => #{val.class.to_s}")
          parse_var(val,depth)
        end
      }
    end
  end
  
end