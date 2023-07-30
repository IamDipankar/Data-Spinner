classdef Spinner < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure             matlab.ui.Figure
        OutputLabel          matlab.ui.control.Label
        BoldButton           matlab.ui.control.Button
        ClearAllButton       matlab.ui.control.Button
        DataSpinnerAppLabel  matlab.ui.control.Label
        InputsTextArea       matlab.ui.control.TextArea
        InputsTextAreaLabel  matlab.ui.control.Label
        ResetButton          matlab.ui.control.Button
        TextArea             matlab.ui.control.TextArea
        TossButton           matlab.ui.control.Button
    end

    
    properties (Access = private)
        value = ""; % Description
        count = 1;
        texts = [];
        isBold = false;
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: TossButton
        function TossButtonPushed(app, event)
            if ~isempty(app.texts)
                app.TextArea.FontAngle = 'normal';
                app.value = app.value + newline + int2str(app.count) + ". " + app.texts(randi(size(app.texts)));
                app.count = app.count + 1;
                app.TextArea.Value = app.value;
            else
                app.TextArea.Value = "<Input is empty>";
                app.TextArea.FontAngle = 'italic';
            end
        end

        % Button pushed function: ResetButton
        function ResetButtonPushed(app, event)
            app.TextArea.Value = "";
            app.value = "";
            app.count = 1;
        end

        % Value changed function: InputsTextArea
        function InputsTextAreaValueChanged(app, event)
            app.texts = split(app.InputsTextArea.Value, newline)';
            app.ResetButtonPushed();
        end

        % Button pushed function: ClearAllButton
        function ClearAllButtonPushed(app, event)
            app.ResetButtonPushed();
            app.InputsTextArea.Value = "";
        end

        % Button pushed function: BoldButton
        function BoldButtonPushed(app, event)
            if app.isBold
                app.TextArea.FontWeight = 'normal';
                app.InputsTextArea.FontWeight = "normal";
                app.BoldButton.FontWeight = "normal";
                app.isBold = false;
            else
                app.TextArea.FontWeight = 'bold';
                app.InputsTextArea.FontWeight = "bold";
                app.BoldButton.FontWeight = "bold";
                app.isBold = true;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 531 405];
            app.UIFigure.Name = 'MATLAB App';

            % Create TossButton
            app.TossButton = uibutton(app.UIFigure, 'push');
            app.TossButton.ButtonPushedFcn = createCallbackFcn(app, @TossButtonPushed, true);
            app.TossButton.Position = [101 70 100 23];
            app.TossButton.Text = 'Toss';

            % Create TextArea
            app.TextArea = uitextarea(app.UIFigure);
            app.TextArea.Editable = 'off';
            app.TextArea.Position = [90 125 163 204];

            % Create ResetButton
            app.ResetButton = uibutton(app.UIFigure, 'push');
            app.ResetButton.ButtonPushedFcn = createCallbackFcn(app, @ResetButtonPushed, true);
            app.ResetButton.Position = [101 31 100 23];
            app.ResetButton.Text = 'Reset';

            % Create InputsTextAreaLabel
            app.InputsTextAreaLabel = uilabel(app.UIFigure);
            app.InputsTextAreaLabel.HorizontalAlignment = 'right';
            app.InputsTextAreaLabel.Position = [304 216 38 22];
            app.InputsTextAreaLabel.Text = 'Inputs';

            % Create InputsTextArea
            app.InputsTextArea = uitextarea(app.UIFigure);
            app.InputsTextArea.ValueChangedFcn = createCallbackFcn(app, @InputsTextAreaValueChanged, true);
            app.InputsTextArea.Position = [357 125 150 204];

            % Create DataSpinnerAppLabel
            app.DataSpinnerAppLabel = uilabel(app.UIFigure);
            app.DataSpinnerAppLabel.FontSize = 20;
            app.DataSpinnerAppLabel.FontWeight = 'bold';
            app.DataSpinnerAppLabel.Position = [181 353 172 26];
            app.DataSpinnerAppLabel.Text = 'Data Spinner App';

            % Create ClearAllButton
            app.ClearAllButton = uibutton(app.UIFigure, 'push');
            app.ClearAllButton.ButtonPushedFcn = createCallbackFcn(app, @ClearAllButtonPushed, true);
            app.ClearAllButton.Position = [341 31 100 23];
            app.ClearAllButton.Text = 'Clear All';

            % Create BoldButton
            app.BoldButton = uibutton(app.UIFigure, 'push');
            app.BoldButton.ButtonPushedFcn = createCallbackFcn(app, @BoldButtonPushed, true);
            app.BoldButton.Position = [341 69 100 23];
            app.BoldButton.Text = 'Bold';

            % Create OutputLabel
            app.OutputLabel = uilabel(app.UIFigure);
            app.OutputLabel.Position = [44 216 42 22];
            app.OutputLabel.Text = 'Output';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Spinner

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end