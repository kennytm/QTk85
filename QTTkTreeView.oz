functor
import
    Tk
    QTkDevel(
        init: Init
        tkInit: TkInit
        qTkClass: QTkClass
        globalInitType: GlobalInitType
        globalUnsetType: GlobalUnsetType
        globalUngetType: GlobalUngetType
        splitParams: SplitParams
    ) at 'x-oz://system/wp/QTkDevel.ozf'

export
    Register

define
    TTkTreeView = {Tk.newWidgetClass noCommand 'ttk::treeview'}

    fun {ColumnIdentifiers L}
        UnVs = {Map L VirtualString.toString}
        SRec = {List.toTuple s UnVs}
    in
        SRec
    end

    SpecialFeaturesNames = [columns headings]

    class QTTkTreeView from TTkTreeView QTkClass
        feat
            widgetType: treeview
            action
            typeInfo: r(
                all: {Record.adjoin GlobalInitType r(
                    columns: listVs
                    headings: no    % can't check, but should be something like 'headings(a:"Alice" b:"Bob" c:"Cat")'
                    action: action
                    selectmode: [extended browse none]
                )}
                uninit: r(1:unit)
                unset: {Record.adjoin GlobalUnsetType r(
                    1: unit
                )}
                unget: {Record.adjoin GlobalUngetType r(
                    headings: unit
                )}
            )


        meth !Init(...) = M
            lock NormalFeatures SpecialFeatures in
                QTkClass,M
                {SplitParams M SpecialFeaturesNames NormalFeatures SpecialFeatures}
                TTkTreeView,{TkInit NormalFeatures}
                {self SetSpecialFeatures(SpecialFeatures)}
                {self tkBind(event:"<<TreeviewSelect>>"  action:{self.action action($)})}
            end
        end

        meth set(...) = M
            lock NormalFeatures SpecialFeatures in
                {SplitParams M SpecialFeaturesNames NormalFeatures SpecialFeatures}
                QTkClass,NormalFeatures
                {self SetSpecialFeatures(SpecialFeatures)}
            end
        end

        meth get(...) = M
            lock NormalFeatures SpecialFeatures in
                {SplitParams M 1|SpecialFeaturesNames NormalFeatures SpecialFeatures}
                QTkClass,NormalFeatures
                {self GetSpecialFeatures(SpecialFeatures)}
            end
        end

        meth SetSpecialFeatures(SpecialFeatures)
            {Record.forAllInd SpecialFeatures proc {$ K V}
                case K
                of columns then
                    {self tk(configure columns: {ColumnIdentifiers V})}
                [] headings then
                    {Record.forAllInd V proc {$ K2 V2}
                        {self tk(heading K2 text:V2)}
                    end}
                end
            end}
        end

        meth GetSpecialFeatures(SpecialFeatures)
            {Record.forAllInd SpecialFeatures proc {$ K ?V}
                case K
                of 1 then
                    V = {self tkReturnListString(selection $)}
                end
            end}
        end


        meth makeTree
                {self tk(insert v("{}") 'end' id:one text:"One" open:true)}
                {self tk(insert one 'end' id:two text:"Two" open:true)}
                {self tk(insert one 'end' id:three text:"Three" open:true)}
                {self tk(insert v("{}") 'end' id:four text:"Four" open:true)}
                {self tk(insert three 'end' id:five text:"Five" open:true)}
        end
    end

    Register = [r(
        widgetType: treeview
        feature: false
        widget: QTTkTreeView
    )]
end

