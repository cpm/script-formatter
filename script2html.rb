# Convert plaintext stage plays to HTML, for a limited subset of plaintext 
# stage plays.
#
# Software does nothing nice for titles or pages yet.
# It assumes the following:
#  * dialogue lines start with NAME IN CAPS followed by ":" or ".".
#  * stage direction is wraps in parens.
#  * other emphasized things are between /'s.
#  * an actor's line can span multiple lines and is terminated by an empty line

# Usage:
#  $ cat my-script.txt | ruby script2html.rb > output.html

def main
  buf = ""
  puts "<html><head><link rel='stylesheet' href='style.css'></head><body>"

  $stdin.each do |line|
    buf << line
    if line == "\n"
      puts process_entity(buf)
      buf = ""
    end
  end

  unless buf == ""
    puts process_entity(buf)
  end

  puts "</body></html>"
end


def process_entity(str)
  html = str.
    gsub(/\/([^\/]+)\//, '<span class="slashy">\1</span>').
    gsub(/\A[A-Z ]+[\.:]/) { |s| "<span class='speaker'>#{s.ucfirst}</span>" }.
    gsub(/\b[A-Z]+\b/) { |s| "<span class='cappy'>#{s.ucfirst}</span>" }.
    gsub(/([(][^)]+[)])/, '<span class="paren">\1</span>').
    gsub("...", "&hellip;")

  "<div class='entity'>#{html}</div>"
end

# It's my party and I'll monkeypatch if I want to.
class String
  # I want things IN ALL CAPS to end up in small caps.
  # ZOMG WTF BBQ?? turns into Zomg Wtf Bbq
  def ucfirst
    self.split(" ").collect { |str|
      "#{str[0].upcase}#{str[1..-1].downcase}"
    }.join(" ")
  end
end

main
