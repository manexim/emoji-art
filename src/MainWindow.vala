/*
 * Copyright (c) 2020 Manexim (https://github.com/manexim)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 *
 * Authored by: Marius Meisenzahl <mariusmeisenzahl@gmail.com>
 */

public class MainWindow : Gtk.ApplicationWindow {
    private Models.Paint model;
    private Gtk.HeaderBar headerbar;
    private Granite.Widgets.Toast toast;

    public Application app { get; construct; }

    public SimpleActionGroup actions { get; construct; }

    public const string ACTION_PREFIX = "win.";
    public const string ACTION_QUIT = "action-quit";
    public const string ACTION_COPY_TO_CLIPBOARD = "action-copy-to-clipboard";

    private static Gee.MultiMap<string, string> action_accelerators = new Gee.HashMultiMap<string, string> ();

    private const ActionEntry[] ACTION_ENTRIES = {
        { ACTION_QUIT, action_quit },
        { ACTION_COPY_TO_CLIPBOARD, action_copy_to_clipboard }
    };

    public MainWindow (Application app) {
        Object (
            app: app
        );
    }

    static construct {
        action_accelerators[ACTION_QUIT] = "<Control>q";
        action_accelerators[ACTION_QUIT] = "<Control>w";
        action_accelerators[ACTION_COPY_TO_CLIPBOARD] = "<Control>c";
    }

    construct {
        set_default_size (400, 400);
        window_position = Gtk.WindowPosition.CENTER;
        resizable = false;

        actions = new SimpleActionGroup ();
        actions.add_action_entries (ACTION_ENTRIES, this);
        insert_action_group ("win", actions);

        set_application (app);

        foreach (var action in action_accelerators.get_keys ()) {
            var accels_array = action_accelerators[action].to_array ();
            accels_array += null;

            app.set_accels_for_action (ACTION_PREFIX + action, accels_array);
        }

        get_style_context ().add_class ("rounded");

        model = new Models.Paint (8, 8);

        headerbar = new Gtk.HeaderBar () {
            show_close_button = true
        };
        headerbar.get_style_context ().add_class ("default-decoration");

        var copy_button = new Gtk.Button.from_icon_name ("edit-copy-symbolic", Gtk.IconSize.MENU) {
            action_name = ACTION_PREFIX + ACTION_COPY_TO_CLIPBOARD,
            tooltip_markup = Granite.markup_accel_tooltip (
                application.get_accels_for_action (ACTION_PREFIX + ACTION_COPY_TO_CLIPBOARD),
                "Copy to clipboard"
            )
        };

        headerbar.pack_end (copy_button);

        set_titlebar (headerbar);
        title = Config.APP_NAME;

        var view = new Views.PaintView (model);

        toast = new Granite.Widgets.Toast ("");

        var overlay = new Gtk.Overlay ();

        overlay.add_overlay (view);
        overlay.add_overlay (toast);

        add (overlay);
    }

    private void action_quit () {
        destroy ();
    }

    private void action_copy_to_clipboard () {
        var display = get_display ();
        var clipboard = Gtk.Clipboard.get_for_display (display, Gdk.SELECTION_CLIPBOARD);
        clipboard.set_text (model.to_string (), -1);

        toast.title = "Successfully copied to clipboard";
        toast.set_default_action (null);
        toast.send_notification ();
    }
}
