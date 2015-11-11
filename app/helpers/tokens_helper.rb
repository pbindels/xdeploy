module TokensHelper

  def run_helper( levels, current, all_tokens, env, token, color)

    found = false
    td ="<td>NA</td>"

    levels.each do |level|
      if all_tokens[env][level].include?(token) && !found
        if current != all_tokens[env][level][token].value
          ##td = "<td bgcolor=\"#{color}\"><b>  #{all_tokens[env][level][token].value} </b> </td>"
          td = "<td bgcolor=\"#{color}\"><a href= \"/tokens/#{all_tokens[env][level][token].id}/edit\">#{all_tokens[env][level][token].value}</a></td>"
          #td = "<td bgcolor =\"#{color}\"> render partial: 'token_leaf', locals: {token: #{all_tokens[env][level][token]}}"

        else
          td = "<td>  #{all_tokens[env][level][token].value}  </td>"
          #td = "<td><a href= \"/tokens/#{all_tokens[env][level][token].id}/edit\">#{all_tokens[env][level][token].value}</a></td>"
          #td = "<td><a href= \"/tokens/#{all_tokens[env][level][token].id}/edit\">#{all_tokens[env][level][token].value}</a></td>"
        end
        found = true
        current = all_tokens[env][level][token].value
      end
    end

    return td, current

  end

  def run_helper2( levels, current, all_tokens, env, token, color)

    found = false
    ele ="NOT SET"
    editable = false
    color = false
    index = 0

    levels.each do |level|
      if all_tokens[env][level].include?(token) && !found

        index == 0 ? editable = true : editable = false
        #index == 0 ?  ele = all_tokens[env][level][token] : ele = "NOT SET"
        ele = all_tokens[env][level][token]

        if current != all_tokens[env][level][token].value  && level != "topenv"
          color = true
        else
          color = false
        end
        found = true
        level != "topenv" && level != "s2e" ?  current = all_tokens[env][level][token].value : current = current
      end
      index += 1
    end

    return ele, current, editable, color

  end


end
