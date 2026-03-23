pragma Singleton
import QtQuick

QtObject {
    id: root

    // ── Matugen color file path ───────────────────────────────
    readonly property string colorFile: StandardPaths.writableLocation(
        StandardPaths.HomeLocation) + "/.cache/matugen/colors.json"

    // ── Reactive color properties ─────────────────────────────
    property color primary:       "#cba6f7"
    property color onPrimary:     "#1e1e2e"
    property color secondary:     "#89b4fa"
    property color surface:       "#1e1e2e"
    property color surfaceVariant:"#313244"
    property color onSurface:     "#cdd6f4"
    property color outline:       "#585b70"
    property color error:         "#f38ba8"

    // ── Derived convenience colors ────────────────────────────
    property color pillBg:        Qt.rgba(surface.r, surface.g, surface.b, 0.85)
    property color pillBorder:    Qt.rgba(outline.r, outline.g, outline.b, 0.4)
    property color pillText:      onSurface
    property color pillAccent:    primary
    property color pillMuted:     Qt.rgba(onSurface.r, onSurface.g, onSurface.b, 0.5)

    // ── File watcher ──────────────────────────────────────────
    FileView {
        id: colorFileView
        path: root.colorFile
        onTextChanged: root._parseColors(text)
    }

    function _parseColors(text) {
        if (!text || text.length === 0) return
        try {
            const data = JSON.parse(text)
            const colors = data?.colors?.dark ?? data?.colors ?? {}

            if (colors.primary)        root.primary        = colors.primary
            if (colors.on_primary)     root.onPrimary      = colors.on_primary
            if (colors.secondary)      root.secondary      = colors.secondary
            if (colors.surface)        root.surface        = colors.surface
            if (colors.surface_variant) root.surfaceVariant = colors.surface_variant
            if (colors.on_surface)     root.onSurface      = colors.on_surface
            if (colors.outline)        root.outline        = colors.outline
            if (colors.error)          root.error          = colors.error
        } catch (e) {
            console.warn("Rocko Colors: failed to parse matugen output:", e)
        }
    }

    Component.onCompleted: {
        if (colorFileView.text) _parseColors(colorFileView.text)
    }
}
