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
    ) at 'x-oz://system/wp/QTkDevel.ozf'

export
    Register

define
    TkSpinBox = {Tk.newWidgetClass noCommand spinbox}

    class QTkSpinBox from TkSpinBox QTkClass
        feat
            TkVar
            widgetType: spinbox
            typeInfo: r(
                all: {Record.adjoin GlobalInitType r(
                    'from': float
                    to: float
                    wrap: boolean
                )}
                uninit: r(1:unit)
                unset: {Record.adjoin GlobalUnsetType r(
                    1: unit
                )}
                unget: {Record.adjoin GlobalUngetType r(
                    1: unit
                )}
            )

        meth !Init(...) = M
            lock
                QTkClass,M
                self.TkVar = {New Tk.variable tkInit()}
                TkSpinBox,{TkInit M}
            end
        end
    end

    Register = [r(
        widgetType: spinbox
        feature: false
        widget: QTkSpinBox
    )]
end

