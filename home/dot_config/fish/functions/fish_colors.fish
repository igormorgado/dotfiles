#!/usr/bin/env fish
                                                                                                                                                         
function colors --description "List terminal colors"

  set_color 121212; echo "00. XXXXXXXXX"
  set_color ff7c59; echo "01. XXXXXXXXX"
  set_color 48d56b; echo "02. XXXXXXXXX"
  set_color ffb94c; echo "03. XXXXXXXXX"
  set_color 84a7f2; echo "04. XXXXXXXXX"
  set_color ff66e4; echo "05. XXXXXXXXX"
  set_color 39e7d8; echo "06. XXXXXXXXX"
  set_color eeeeee; echo "07. XXXXXXXXX"
  set_color 4e4e4e; echo "08. XXXXXXXXX"
  set_color b51530; echo "09. XXXXXXXXX"
  set_color 076b47; echo "10. XXXXXXXXX"
  set_color 934305; echo "11. XXXXXXXXX"
  set_color 10237a; echo "12. XXXXXXXXX"
  set_color 9700b7; echo "13. XXXXXXXXX"
  set_color 005c7d; echo "14. XXXXXXXXX"
  set_color b2b2b2; echo "16. XXXXXXXXX"

  set y (math "ceil(256/($LINES-2))")
  set x (math "ceil(256/sqrt($COLUMNS))")
  for r in (seq 0 $y 255)
    for g in (seq 0 $x 255)
      for b in (seq 0 $x 255)
        set_color -b (printf "%02X%02X%02X" $r $g $b); echo -n " "
      end
    end
    echo
  end
end
