{ pkgs, themeName, ... }:

let
  theme = import ../shared/theme.nix themeName;
  c = theme.colors;

  # Generate Halloy theme from system theme
  halloyTheme = ''
    # ${theme.name} theme for Halloy
    # Auto-generated from Nix theme system

    [general]
    background = "${c.bg}"
    horizontal_rule = "${c.bgLighter}"
    scrollbar = "${c.selection}"
    unread_indicator = "${c.red}"
    highlight_indicator = "${c.yellow}"
    border = "${c.selection}"

    [text]
    primary = "${c.fg}"
    secondary = "${c.cursor}"
    tertiary = "${c.comment}"
    success = "${c.green}"
    error = "${c.red}"
    warning = "${c.orange}"
    info = "${c.cyan}"
    debug = "${c.purple}"
    trace = "${c.comment}"

    [buffer]
    background = "${c.bg}"
    background_text_input = "${c.bgLighter}"
    background_title_bar = "${c.bgLighter}"
    timestamp = "${c.purple}"
    action = "${c.green}"
    topic = "${c.cursor}"
    highlight = "${c.bgLighter}"
    code = "${c.purple}"
    nickname = "${c.cyan}"
    nickname_offline = "${c.comment}"
    url = "${c.cyan}"
    selection = "${c.selection}"
    border_selected = "${c.red}"

    [buffer.server_messages]
    default = "${c.comment}"

    [buttons.primary]
    background = "${c.bg}"
    background_hover = "${c.bgLighter}"
    background_selected = "${c.selection}"
    background_selected_hover = "${c.comment}"

    [buttons.secondary]
    background = "${c.bgLighter}"
    background_hover = "${c.selection}"
    background_selected = "${c.comment}"
    background_selected_hover = "${c.cursor}"

    [formatting]
    white = "${c.fg}"
    black = "${c.bg}"
    blue = "${c.cyan}"
    green = "${c.green}"
    red = "${c.red}"
    brown = "${c.selection}"
    magenta = "${c.purple}"
    orange = "${c.orange}"
    yellow = "${c.yellow}"
    lightgreen = "${c.green}"
    cyan = "${c.cyan}"
    lightcyan = "${c.cyan}"
    lightblue = "${c.cyan}"
    pink = "${c.red}"
    grey = "${c.comment}"
    lightgrey = "${c.cursor}"
  '';

  # Halloy config
  halloyConfig = ''
    # Halloy config - managed by Nix
    # https://halloy.chat/configuration.html

    theme = "${themeName}"

    [font]
    family = "Berkeley Mono"
    size = 13
    weight = "normal"

    # ═══════════════════ SERVERS ═══════════════════

    [servers.rizon]
    nickname = "dieman"
    server = "irc.rizon.net"
    channels = ["#elite-chat", "#ELITEWAREZ"]
    chathistory = false

    [servers.rizon.sasl.plain]
    username = "dieman"
    password_command = "/opt/homebrew/bin/op read 'op://Private/Rizon IRC/password'"

    [servers.liberachat]
    nickname = "dieman"
    server = "irc.libera.chat"
    channels = ["#elixir", "#halloy", "#linux", "#nixos"]

    [servers.liberachat.sasl.plain]
    username = "dieman"
    password_command = "/opt/homebrew/bin/op read 'op://Private/Rizon IRC/password'"

    [servers.azzurra]
    nickname = "dieman"
    server = "irc.azzurra.chat"
    port = 6667
    use_tls = false
    channels = ["#irchelp", "#italia", "#scripters"]
    nick_password_command = "/opt/homebrew/bin/op read 'op://Private/Rizon IRC/password'"

    # ═══════════════════ BEHAVIOR ═══════════════════

    [actions.buffer]
    click_channel_name = "replace-pane"
    click_highlight = "replace-pane"
    click_username = "replace-pane"
    local = "replace-pane"
    message_channel = "replace-pane"
    message_user = "replace-pane"

    [actions.sidebar]
    buffer = "replace-pane"
    focused_buffer = "close-pane"

    [sidebar]
    position = "left"
    show_menu_button = true
    order_by = "config"

    # ═══════════════════ DISPLAY ═══════════════════

    [buffer.nickname]
    color = "unique"
    show_access_levels = true
    brackets = { left = "", right = "" }
    alignment = "left"

    [buffer.channel.nicklist]
    color = "unique"
    show_access_levels = true
    position = "right"

    [buffer.timestamp]
    format = "%H:%M"
    brackets = { left = "", right = "" }

    [buffer.date_separators]
    show = true
    format = "%A, %B %-d"

    [buffer.channel.topic_banner]
    enabled = true

    # ═══════════════════ SETTINGS ═══════════════════

    [buffer.backlog_separator]
    hide_when_all_read = true

    [buffer.emojis]
    show_picker = true
    auto_replace = true

    [buffer.status_message_prefix]
    brackets = { left = "* ", right = "" }

    [buffer.mark_as_read]
    on_scroll_to_bottom = true
    on_message_sent = true
    on_buffer_close = "scrolled-to-bottom"

    [buffer.server_messages.join]
    enabled = false
    [buffer.server_messages.part]
    enabled = false
    [buffer.server_messages.quit]
    enabled = false
    [buffer.server_messages.change_nick]
    enabled = false

    # ═══════════════════ NOTIFICATIONS ═══════════════════

    [notifications.highlight]
    sound = "ring"
    show_toast = true

    [notifications.direct_message]
    sound = "peck"
    show_toast = true

    [preview]
    enabled = false

    [buffer.url]
    prompt_before_open = false

    # ═══════════════════ KEYBOARD ═══════════════════

    [keyboard]
    cycle_next_buffer = "super+down"
    cycle_previous_buffer = "super+up"
    cycle_next_unread_buffer = "super+shift+down"
    cycle_previous_unread_buffer = "super+shift+up"
    close_buffer = "super+w"
    toggle_sidebar = "super+b"
    toggle_nick_list = "super+u"
    command_bar = "super+k"
  '';
in
{
  home.file = {
    "Library/Application Support/halloy/config.toml".text = halloyConfig;
    "Library/Application Support/halloy/themes/${themeName}.toml".text = halloyTheme;
  };
}
