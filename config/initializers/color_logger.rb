class ColorLogger
  CTRL        = 27.chr
  RESET_CODES = CTRL + "[0m"
  
  BOLD_ON  = CTRL + "[1m"
  BOLD_OFF = CTRL + "[22m"
  
  # Set defaults
  @@text = :white
  @@bg   = :blue
  
  COLORS = {
    :text => {
      :black =>   CTRL + "[30m",
      :red =>     CTRL + "[31m",
      :green =>   CTRL + "[32m",
      :yellow =>  CTRL + "[33m",
      :blue =>    CTRL + "[34m",
      :magenta => CTRL + "[35m",
      :cyan =>    CTRL + "[36m",
      :white =>   CTRL + "[37m"
    },
    
    :bg => {
      :black =>   CTRL + "[40m",
      :red =>     CTRL + "[41m",
      :green =>   CTRL + "[42m",
      :yellow =>  CTRL + "[43m",
      :blue =>    CTRL + "[44m",
      :magenta => CTRL + "[45m",
      :cyan =>    CTRL + "[46m",
      :white =>   CTRL + "[47m"
    }
  }
  
  def self.colorize(message, args={})
    (message = message.inspect) unless message.class == String
    # Fall back to default colors if they pass invalid color names
    args.delete(:text) if (args.has_key?(:text) && !COLORS[:text].has_key?(args[:text]))
    args.delete(:bg) if (args.has_key?(:bg) && !COLORS[:bg].has_key?(args[:bg]))
    
    COLORS[:text][args[:text] || @@text] + COLORS[:bg][args[:bg] || @@bg] + (args[:bold] ? BOLD_ON : BOLD_OFF) + message + RESET_CODES
  end
end

def c(message, args={})
  ColorLogger.colorize(message, args)
end

def colog(input)
  logger.debug "\n" + 27.chr + "[7m" + 27.chr + "[34m" + input + 27.chr + "[0m" + "\n"
end
