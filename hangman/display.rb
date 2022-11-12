require 'colorize'

class Display

  def title
    %{
    ██   ██  █████  ███    ██  ██████  ███    ███  █████  ███    ██ 
    ██   ██ ██   ██ ████   ██ ██       ████  ████ ██   ██ ████   ██ 
    ███████ ███████ ██ ██  ██ ██   ███ ██ ████ ██ ███████ ██ ██  ██ 
    ██   ██ ██   ██ ██  ██ ██ ██    ██ ██  ██  ██ ██   ██ ██  ██ ██ 
    ██   ██ ██   ██ ██   ████  ██████  ██      ██ ██   ██ ██   ████ 
    }
  end

  def main(mr, display_array, fails_array, alphabet)
    %{
                __________    #{display_array}  (#{display_array.length}letter word)
               |          |                                                                     Incorrect:
               O          |                                                                    #{fails_array}
              /|\\       ██   ██  █████  ███    ██  ██████  ███    ███  █████  ███    ██       
               |        ██   ██ ██   ██ ████   ██ ██       ████  ████ ██   ██ ████   ██        
              / \\       ███████ ███████ ██ ██  ██ ██   ███ ██ ████ ██ ███████ ██ ██  ██        
      Moves             ██   ██ ██   ██ ██  ██ ██ ██    ██ ██  ██  ██ ██   ██ ██  ██ ██        
      Remaining: #{mr.to_s.red}      ██   ██ ██   ██ ██   ████  ██████  ██      ██ ██   ██ ██   ████ 

      #{alphabet.join(" ")}
    }
  end
end