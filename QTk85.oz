functor
import
    %Tk
    QTk at 'x-oz://system/wp/QTk.ozf'
    %QTkDevel
    QTkSpinBox
    QTTkTreeView

export
    build: Build
    newBuilder: GetBuilder

define
    Controls = [
        QTkSpinBox
        QTTkTreeView
    ]

    % -- GetBuilder ------------------------------------------------------------
    % --------------------------------------------------------------------------
    % Get a QTk builder extended for Tk 8.5.
    fun {GetBuilder}
        Builder = {QTk.newBuilder}
    in
        for Control in Controls do
            for CReg in Control.register do
                {Builder.register CReg}
            end
        end
        Builder
    end

    Build = {GetBuilder}.build
end

