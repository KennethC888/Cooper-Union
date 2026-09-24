# ANSI Color Code Examples to help make sense of the regex expressions below
# Git config color code descriptions; see here:
# https://stackoverflow.com/questions/26941144/how-do-you-customize-the-color-of-the-diff-header-in-git-diff/61993060#61993060
# ---------------    ----------------------------------------------------------------
#                    Git config color code desription
# ANSI Color Code    Order: text_color(x1) background_color(x1) attributes(0 or more)
# ----------------   ----------------------------------------------------------------
# \033[m             # code to turn off or "end" the previous color code
# \033[1m            # "white"
# \033[31m           # "red"
# \033[32m           # "green"
# \033[33m           # "yellow"
# \033[34m           # "blue"
# \033[36m           # "cyan"
# \033[1;33m         # "yellow bold"
# \033[1;36m         # "cyan bold"
# \033[3;30;42m      # "black green italic" = black text with green background, italic text
# \033[9;30;41m      # "black red strike" = black text with red background, strikethrough line through the text

# Note: you can use \e[1m makes the font white also