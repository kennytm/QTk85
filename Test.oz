functor
import
    QTk85
    QTkDevel at 'x-oz://system/wp/QTkDevel.ozf'
    Application
    System

define
    UrlEntry
    ClaimPane
    ClaimText

    WindowDesc = td(
        lr(glue: we
            label(text:'Google Patent URL: ')
            entry(handle:UrlEntry  glue:we)
            spinbox()
        )
        lrrubberframe(glue:nswe
            treeview(
                handle: ClaimPane
                columns: [type]
                headings: r('#0':'#'  type:'Type')
                selectmode: browse
                action: proc {$}
                    Selected = {ClaimPane get($)}
                in
                    {ClaimText set(Selected.1)}
                end
            )
            text(
                handle: ClaimText
                init: 'Result'
                tdscrollbar: true
                font: 'Helvetica 17'
            )
        )
    )

    Builder = {QTk85.newBuilder}
    Window = {Builder.build WindowDesc}
in
    %{QTkDevel.setAssertLevel all full}

    %{System.show Builder.defaultLook}
    {ClaimPane makeTree}

    {Window show}
    {Window wait}
    {Application.exit 0}
end



