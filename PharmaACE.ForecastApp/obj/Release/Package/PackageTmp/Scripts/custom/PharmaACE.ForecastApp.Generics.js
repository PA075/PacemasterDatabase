(function (PHARMAACE) {
    (function (FORECASTAPP) {
        (function (GENERICS) {

            PHARMAACE.FORECASTAPP.GENERICS.getSkuCount = function () {
                var ele = document.getElementById('selectSKU');
                if (ele.options[ele.selectedIndex].value)
                    return ele.options.length;
                return 0;
            }

            PHARMAACE.FORECASTAPP.GENERICS.isTotalSku = function () {
                var ele = document.getElementById('selectSKU');
                return ele.selectedIndex == 1 + PHARMAACE.FORECASTAPP.GENERICS.getSkuCount();
            }

            PHARMAACE.FORECASTAPP.GENERICS.populateForecastView = function () {
                //InitializeDisplay();
                PHARMAACE.FORECASTAPP.GENERICS.Application_Events_Handler(false);
                PHARMAACE.FORECASTAPP.GENERICS.Create_Forecast_Master();
                PHARMAACE.FORECASTAPP.GENERICS.populateDataForProductSKUScenario();
                PHARMAACE.FORECASTAPP.GENERICS.postProcess();
                //PHARMAACE.FORECASTAPP.GENERICS.FinalizeDisplay();
            }

            PHARMAACE.FORECASTAPP.GENERICS.populateDataForProductSKUScenario = function () {
                PHARMAACE.FORECASTAPP.GENERICS.populateHistoricalData(PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].HistoricalData);
                PHARMAACE.FORECASTAPP.GENERICS.populateOutputData(PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].ForecastData);
                PHARMAACE.FORECASTAPP.GENERICS.populateEventData(PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].EventSections);
                PHARMAACE.FORECASTAPP.GENERICS.No_Packs_Actual();
                PHARMAACE.FORECASTAPP.GENERICS.No_Events();
                PHARMAACE.FORECASTAPP.GENERICS.Event_Erosion();
                //setForecastLabels();
            }

            PHARMAACE.FORECASTAPP.GENERICS.setForecastLabels = function () {
                var ele = document.getElementById('selectProduct');
                PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Shapes("TextBox 53").TextFrame.Characters.Text = ele.options[ele.selectedIndex].text;
                ele = document.getElementById('selectSKU');
                PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Shapes("TextBox 54").TextFrame.Characters.Text = ele.options[ele.selectedIndex].text;
                ele = document.getElementById('selectScenario');
                PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Shapes("TextBox 55").TextFrame.Characters.Text = ele.options[ele.selectedIndex].text;
            }

            PHARMAACE.FORECASTAPP.GENERICS.No_Packs_Actual = function () {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                hideshowRows(sheet, 170, 260, true);
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A170:A260").EntireRow.Hidden = true;
                var packCount = PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].Packs.length;
                if (packCount > 0) {
                    hideshowRows(sheet, 170, packCount + 171, false);
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A170:A{1}".replace("{1}", packCount + 171)).EntireRow.Hidden = false;
                    hideshowRows(sheet, 187, intRng2 + 188, false);
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A187:A" & intRng2 + 188).EntireRow.Hidden = false;
                    hideshowRows(sheet, 204, intRng2 + 205, false);
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A204:A" & intRng2 + 205).EntireRow.Hidden = false;
                    hideshowRows(sheet, 221, intRng2 + 222, false);
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A221:A" & intRng2 + 222).EntireRow.Hidden = false;
                    hideshowRows(sheet, 238, intRng2 + 239, false);
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A238:A" & intRng2 + 239).EntireRow.Hidden = false;
                    PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Shapes("shp_Advanced_Price_Split_G2").Visible = 0;
                    PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Shapes("shp_Advanced_Price_Split_PGTN").Visible = -1;
                    PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Shapes("shp_Advanced_Price_Split_P").Visible = 0;
                    PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Shapes("shp_Advanced_Price_Split").Visible = 0;
                    PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G240:NB254").Formula = "=G223*G206*G189";
                    PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("F206:F220").Formula = "=F189";
                    PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("F223:F237").Formula = "=F206";
                    PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("F240:F254").Formula = "=F223";
                }
            }

            PHARMAACE.FORECASTAPP.GENERICS.No_Events = function () {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                var eventCount = PHARMAACE.FORECASTAPP.GENERICS.getEventSectionDepth(1);
                hideshowRows(sheet, 119, 144, true);
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A119:A144").EntireRow.Hidden = true;
                if(eventCount != 0){
                    //hideshowRows(sheet, 143, 144, true);
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A143:A144").EntireRow.Hidden = true;
                //}
                    //else{
                    hideshowRows(sheet, 119, eventCount + 120, false);
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A119:A{1}".replace("{1}", eventCount + 120)).EntireRow.Hidden = false;
                    hideshowRows(sheet, 131, eventCount + 132, false);
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A131:A{1}".replace("{1}", eventCount + 132)).EntireRow.Hidden = false;
                    hideshowRows(sheet, 143, 146, false);
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A143:A146").EntireRow.Hidden = false;
                }
            }

            PHARMAACE.FORECASTAPP.GENERICS.getEventSectionDepth = function (section) {
                for(var i = 0; i < PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].EventSections.length; i++){
                    if(PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].EventSections[i].Section == section)
                        return PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].EventSections[i].Events.length;
                }

                return 0;
            }

            PHARMAACE.FORECASTAPP.GENERICS.Event_Erosion = function () {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                var productIndex = document.getElementById('selectProduct').selectedIndex;
                var skuIndex = document.getElementById('selectSKU').selectedIndex;
                var scenarioIndex = document.getElementById('selectScenario').selectedIndex;
        
                hideshowRows(sheet, 94, 108, true);
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A94:A108").EntireRow.Hidden = true;
                var primaryEventCount = PHARMAACE.FORECASTAPP.GENERICS.getEventSectionDepth(3);
                if (primaryEventCount > 1) {
                    hideshowRows(sheet, 94, primaryEventCount + 94, false);
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A94:A{1}".replace("{1}", primaryEventCount + 94)).EntireRow.Hidden = false;
                    hideshowRows(sheet, 102, primaryEventCount + 101, false);
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A102:A{1}".replace("{1}", primaryEventCount + 101)).EntireRow.Hidden = false;
                    hideshowRows(sheet, 100, primaryEventCount + 101, false);
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A100:A101").EntireRow.Hidden = false;
                    //commenting the following as these event names will be set automatically as part of event details
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("F95").Value = "Brand Event";
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("F96").Value = "Generic Erosion";
                    hideshowRows(sheet, 107, 108, false);
                    //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("A107:A108").EntireRow.Hidden = false;
                    //commenting the following as the following statement is identical
                    //if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.ForecastProducts[productIndex].Projection == 0) //Projection = Market
                    //    PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G102:NB106").Formula = '=IF($G95="On",IF(Generic_Forecast!G$10<$L95,0,P_MB_Transition($I95,$J95,$K95,$M95*24,,$L95,Generic_Forecast!G$10,12,"Monthly")),0)*IF($H95="Positive",1,-1)';
                    PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G102:NB106").Formula = '=IF($G95="On",IF(Generic_Forecast!G$10<$L95,0,P_MB_Transition($I95,$J95,$K95,$M95*24,,$L95,Generic_Forecast!G$10,12,"Monthly")),0)*IF($H95="Positive",1,-1)';            
                }
            }

            PHARMAACE.FORECASTAPP.GENERICS.postProcess = function () {
                if(!PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv || !PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey])
                    return;
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                var historicalColumnTill = PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.HistoricalTimeStep;
                var lastHistoricalColumnLetter = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, historicalColumnTill - 1);
                var postHistoricalColumnLetter = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, historicalColumnTill);
                var forecastColumnTill = PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.TotalTimeStep;
                var showColumnTill = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, forecastColumnTill - 1);
                var hideColumnFrom = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, forecastColumnTill);
                var productIndex = document.getElementById('selectProduct').selectedIndex;
                var skuIndex = document.getElementById('selectSKU').selectedIndex;
                var scenarioIndex = document.getElementById('selectScenario').selectedIndex;        
        
                sheet.Range("G114:NB114").Interior.Color = 16777215;
                if(PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].Penetration){
                    if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].Penetration.Type == 1) //Calculated
                    {
                        if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.ForecastProducts[productIndex].Type == 0) //Inline        
                            sheet.Range("G114:NB114").Formula = '=IF(G$10<$J113,G67,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,"Monthly"))';
                        else
                            sheet.Range("G114:NB114").Formula = '=IF(G$10<$J113,0,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,"Monthly"))';
                    }
                    else if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].Penetration.Type == 3)
                        sheet.Range("G114:NB114").Interior.Color = 16777215;
                    else if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].Penetration.Type == 2) {
                        sheet.Range("G114:{1}114".replace("{1}", lastHistoricalColumnLetter)).Formula = "=G67";
                        sheet.Range("{0}114:NB114".replace("{0}", postHistoricalColumnLetter)).Interior.Color = 13434879;
                    }
                }
                settleThings();
                sheet.Activate();
                //if wks_Home.Range("T1").Value = 3 Then PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Protect
                
                PHARMAACE.FORECASTAPP.GENERICS.Application_Events_Handler(true);
            }

            PHARMAACE.FORECASTAPP.GENERICS.Create_Forecast_Master = function () {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                arrWhiteRanges = [];
                arrYellowRanges = [];
                arrHiddenRows = [];
                //unhide G to NB column to start with
                for (var i = 6; i < 366; i++) arrHiddenColumns[i] = false;

                var productIndex = document.getElementById('selectProduct').selectedIndex;
                var skuIndex = document.getElementById('selectSKU').selectedIndex;
                var scenarioIndex = document.getElementById('selectScenario').selectedIndex;
                
                //RGB(255, 255, 255) = 16777215
                arrWhiteRanges.push("G114:NB114");
                //sheet.Range("G114:NB114").Interior.Color = 16777215;
                //arrDisplayedColumns.push("H1:NB1");
                //sheet.Range("H1:NB1").EntireColumn.Hidden = false;
                sheet.Range("G10").Value = PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.DataAvailableFrom;
                sheet.Calculate();

                if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.ForecastProducts[productIndex].Type == 0) //Inline
                    PHARMAACE.FORECASTAPP.GENERICS.Create_BDL_Inline_Volume();
                else
                    PHARMAACE.FORECASTAPP.GENERICS.Create_BDL_Pipeline_Volume();

                var historicalColumnTill = PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.HistoricalTimeStep - 1;
                var lastHistoricalColumnLetter = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, historicalColumnTill);
                var forecastColumnTill = PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.TotalTimeStep;
                var showColumnTill = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, forecastColumnTill - 1);
                var hideColumnFrom = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, forecastColumnTill);
                hideshowColumns(sheet, hideColumnFrom, "NB", true);
                //sheet.Range("{0}:{1}".replace("{0}", hideColumnFrom).replace("{1}", "NB")).EntireColumn.Hidden = true;
                hideshowColumns(sheet, "G", showColumnTill, false);
                //sheet.Range("{0}:{1}".replace("{0}", "G").replace("{1}", showColumnTill)).EntireColumn.Hidden = false;

                arrWhiteRanges.push("G50:NB64"); 
                arrWhiteRanges.push("G14:NB28"); 
                arrWhiteRanges.push("G70:NB84");
                //sheet.Range("G50:NB64").Interior.Color = 16777215;
                //sheet.Range("G14:NB28").Interior.Color = 16777215;
                //sheet.Range("G70:NB84").Interior.Color = 16777215;
                if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.DataType == 0) //Units
                {
                    arrYellowRanges.push("F50:F64");
                    arrYellowRanges.push("G14:{0}28".replace("{0}", lastHistoricalColumnLetter)),
                    arrYellowRanges.push("G50:{0}64".replace("{0}", lastHistoricalColumnLetter));
                    arrYellowRanges.push("G70:{0}84".replace("{0}", lastHistoricalColumnLetter));
                    //sheet.Range("F50:F64").Interior.Color = 13434879;
                    //sheet.Range("G14:{0}28".replace("{0}", lastHistoricalColumnLetter)).Interior.Color = 13434879;
                    //sheet.Range("G50:{0}64".replace("{0}", lastHistoricalColumnLetter)).Interior.Color = 13434879;
                    //sheet.Range("G70:{0}84".replace("{0}", lastHistoricalColumnLetter)).Interior.Color = 13434879;
                }
                else { //TRx
                    arrYellowRanges.push("G14:{0}28".replace("{0}", lastHistoricalColumnLetter));
                    arrYellowRanges.push("G70:{0}84".replace("{0}", lastHistoricalColumnLetter));
                    arrWhiteRanges.push("F50:NB65");
                    arrWhiteRanges.push("G47:NB47");

                    //sheet.Range("G14:{0}28".replace("{0}", lastHistoricalColumnLetter)).Interior.Color = 13434879;
                    //sheet.Range("F50:NB65").Interior.Color = 16777215;
                    //sheet.Range("G47:NB47").Interior.Color = 16777215;
                    //sheet.Range("G70:{0}84".replace("{0}", lastHistoricalColumnLetter)).Interior.Color = 13434879;
                }
                if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.ForecastProducts[productIndex].Type == 0) //Inline
                {
                    arrWhiteRanges.push("F14"); 
                    arrWhiteRanges.push("F50");
                    //sheet.Range("F14").Interior.Color = 16777215;
                    //sheet.Range("F50").Interior.Color = 16777215;
                }
                else { //Pipeline
                    arrYellowRanges.push("F14"); 
                    arrYellowRanges.push("F50");
                    //sheet.Range("F14").Interior.Color = 13434879;
                    //sheet.Range("F50").Interior.Color = 13434879;
                }

                //missing formulas
                sheet.Range("F101").Value = "Evented Shares";
                sheet.Range("F102:F106").Formula = '=if(F95="","",F95)';
                sheet.Range("F108").Value = "Available Market Units";

                hideshowRows(sheet, 90, 93, false);
                //sheet.Range("A90:A93").EntireRow.Hidden = false;
                hideshowRows(sheet, 109, 109, true);
                //sheet.Range("A109").EntireRow.Hidden = true;

                sheet.Activate();

                //populateAllData(fv, fio);
            }

            function settleThings() {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                var rngWhite = getUnionFromRangeAddresses(sheet, arrWhiteRanges);
                var rngYellow = getUnionFromRangeAddresses(sheet, arrYellowRanges);
                
                rngWhite.Interior.Color = 16777215;
                rngYellow.Interior.Color = 13434879;
                settleColumnsDisplay(sheet);
                settleRowsDisplay(sheet);
            }

            function settleColumnsDisplay(sheet) {
                //make non-intersecting ranges and then hide/show
                var rngHiddenColumns = null;
                var rngDisplayedColumns = null;
                var rngStart = null, rngEnd = null;
                var intRngStart = -1, intRngEnd = -1;
                for (var i = 0; i < arrHiddenColumns.length; i++) {
                    if (arrHiddenColumns[i] === undefined) //undefined or false
                        continue;
                    //we are interested only in hidden columns, as the column's entire set has been displayed in the beginning

                    if (!rngStart){
                        intRngStart = i;
                        rngStart = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, i + 1); // +1 for 0 based vs 1 based
                    }
                    if (rngStart && !rngEnd && arrHiddenColumns[i] != arrHiddenColumns[i + 1]) {
                        intRngEnd = i;
                        rngEnd = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, i + 1); // +1 for 0 based vs 1 based
                        var rng = sheet.Range(rngStart + "1:" + rngEnd + "1");

                        if (arrHiddenColumns[i] == true) {
                            if (!rngHiddenColumns)
                                rngHiddenColumns = rng;
                            else
                                rngHiddenColumns = objExcel.Union(rngHiddenColumns, rng);
                            updateHiddenColumnsArray(intRngStart, intRngEnd, true);
                        }
                        if (arrHiddenColumns[i] == false) {
                            if (!rngDisplayedColumns)
                                rngDisplayedColumns = rng;
                            else
                                rngDisplayedColumns = objExcel.Union(rngDisplayedColumns, rng);
                            updateHiddenColumnsArray(intRngStart, intRngEnd, false);
                        }

                        rngStart = null;
                        rngEnd = null;
                    }
                }

                if (rngHiddenColumns)
                    rngHiddenColumns.EntireColumn.Hidden = true;
                if (rngDisplayedColumns)
                    rngDisplayedColumns.EntireColumn.Hidden = false;
            }

            function settleRowsDisplay(sheet) {
                //make non-intersecting ranges and then hide/show
                var rngHiddenRows = null, rngDisplayedRows = null;
                var rngStart = null, rngEnd = null;
                for (var i = 0; i < arrHiddenRows.length; i++) {
                    if (arrHiddenRows[i] === undefined)
                        continue;
                    if (!rngStart) rngStart = i + 1; // +1 for 0 based vs 1 based
                    if (rngStart && !rngEnd && arrHiddenRows[i] != arrHiddenRows[i + 1]) {
                        rngEnd = i + 1; // +1 for 0 based vs 1 based
                        var rng = sheet.Range("A" + rngStart + ":A" + rngEnd);

                        if (arrHiddenRows[i] == true) {
                            if (!rngHiddenRows)
                                rngHiddenRows = rng;
                            else
                                rngHiddenRows = objExcel.Union(rngHiddenRows, rng);
                            updateHiddenRowsArray(rngStart, rngEnd, true);
                        }
                        if (arrHiddenRows[i] == false) {
                            if (!rngDisplayedRows)
                                rngDisplayedRows = rng;
                            else
                                rngDisplayedRows = objExcel.Union(rngDisplayedRows, rng);
                            updateHiddenRowsArray(rngStart, rngEnd, false);
                        }

                        rngStart = null;
                        rngEnd = null;
                    }
                }

                if (rngHiddenRows)
                        rngHiddenRows.EntireRow.Hidden = true;
                if(rngDisplayedRows)
                    rngDisplayedRows.EntireRow.Hidden = false;                
            }

            function updateHiddenRowsArray(rowStart, rowEnd, hide) {
                for (var i = rowStart; i < rowEnd; i++)
                    hiddenRows[i] = hide;
            }
            function updateHiddenColumnsArray(colStart, colEnd, hide) {
                for (var i = colStart; i < colEnd; i++)
                    hiddenColumns[i] = hide;
            }

            function getUnionFromRangeAddresses(sheet, arrRanges) {
                if (!arrRanges || arrRanges.length == 0)
                    return null;
                var rngUnion = sheet.Range(arrRanges[0]);
                for (var i = 1; i < arrRanges.length; i++)
                    rngUnion = objExcel.Union(rngUnion, sheet.Range(arrRanges[i]));

                return rngUnion;
            }

            function hideshowColumns(sheet, from, to, hide) {
                var iFrom = PHARMAACE.FORECASTAPP.UTILITY.getColumnIndexByLetter(sheet, from);
                var iTo = PHARMAACE.FORECASTAPP.UTILITY.getColumnIndexByLetter(sheet, to);
                //here i is row index according to excel, i.e. 1-based
                for (var i = iFrom; i <= iTo; i++) {
                    //if (sheet.Columns(i).Hidden == hide)
                    if(hiddenColumns[i - 1] == hide)
                        arrHiddenColumns[i - 1] = undefined; //keeping undefined flags prevents hiding a already hidden column and vice-versa
                    else
                        arrHiddenColumns[i - 1] = hide;
                }
            }

            function hideshowRows(sheet, iFrom, iTo, hide) {
                //here i is row index according to excel, i.e. 1-based
                for (var i = iFrom; i <= iTo; i++) {
                    //if (sheet.Rows(i).Hidden == hide)
                    if (hiddenRows[i - 1] == hide)
                        arrHiddenRows[i - 1] = undefined; //keeping undefined flags prevents hiding a already hidden row and vice-versa
                    else
                        arrHiddenRows[i - 1] = hide;
                }
            }

            function paintCellsYellow(sheet, iFrom, iTo, hide) {
                for (var i = iFrom; i <= iTo; i++)
                    arrHiddenRows[i - 1] = hide;
            }

            PHARMAACE.FORECASTAPP.GENERICS.Drop_Down_Change = function () {
                PHARMAACE.FORECASTAPP.GENERICS.Application_Events_Handler(false);
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                var historicalColumnTill = PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.HistoricalTimeStep;
                var lastHistoricalColumnLetter = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, historicalColumnTill - 1);
                var postHistoricalColumnLetter = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, historicalColumnTill);
                var forecastColumnTill = PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.TotalTimeStep;
                var showColumnTill = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, forecastColumnTill - 1);
                var hideColumnFrom = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, forecastColumnTill);
                var productIndex = document.getElementById('selectProduct').selectedIndex;
                var skuIndex = document.getElementById('selectSKU').selectedIndex;
                var scenarioIndex = document.getElementById('selectScenario').selectedIndex;

                sheet.Unprotect();
                if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.ForecastProducts[productIndex].Type == 0) //Inline
                {
                    sheet.Range("F14").Interior.Color = 16777215;
                    sheet.Range("F50").Interior.Color = 16777215;
                    PHARMAACE.FORECASTAPP.GENERICS.BDL_Inline_Hide_Unhide();
                    PHARMAACE.FORECASTAPP.GENERICS.BDL_Inline_Formula();
                }
                else {
                    sheet.Range("F14").Interior.Color = 13434879;
                    sheet.Range("F50").Interior.Color = 13434879;
                    PHARMAACE.FORECASTAPP.GENERICS.BDL_Pipeline_Hide_Unhide();
                    PHARMAACE.FORECASTAPP.GENERICS.BDL_Pipeline_Formula();
                }

                PHARMAACE.FORECASTAPP.GENERICS.populateDataForProductSKUScenario();
                PHARMAACE.FORECASTAPP.GENERICS.For_Total_Selection();
                sheet.Range("G114:NB114").Interior.Color = 16777215;
                if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].Penetration) {
                    if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].Penetration.Type == 1) //Calculated
                    {
                        if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.ForecastProducts[productIndex].Type == 0) //Inline        
                            sheet.Range("G114:NB114").Formula = '=IF(G$10<$J113,G67,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,"Monthly"))';
                        else
                            sheet.Range("G114:NB114").Formula = '=IF(G$10<$J113,0,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,"Monthly"))';
                    }
                        //commenting the following as the color is already set to 16777215 above
                    //else if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].Penetration.Type == 3)
                        //sheet.Range("G114:NB114").Interior.Color = 16777215;
                    else if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].Penetration.Type == 2) {
                        sheet.Range("G114:{1}114".replace("{1}", lastHistoricalColumnLetter)).Formula = "=G67";
                        sheet.Range("{0}114:NB114".replace("{0}", postHistoricalColumnLetter)).Interior.Color = 13434879;
                    }
                }

                PHARMAACE.FORECASTAPP.GENERICS.wks_Trending.Range("A89:A326").EntireRow.Hidden = true;
                hideshowRows(sheet, 90, 93, false);
                hideshowRows(sheet, 109, 109, true);
                //sheet.Range("A90:A93").EntireRow.Hidden = false;
                //sheet.Range("A109").EntireRow.Hidden = true;
                sheet.Range("F101").Value = "Evented Shares";
                sheet.Range("F102:F106").Formula = '=if(F95="","",F95)';
                sheet.Range("F108").Value = "Available Market Units";

                //Case_Message();
                sheet.Activate();
                //If wks_Home.Range("T1").Value = 3 Then wks_Forecast.Protect

                PHARMAACE.FORECASTAPP.GENERICS.Application_Events_Handler(true);
            }

            PHARMAACE.FORECASTAPP.GENERICS.For_Total_Selection = function () {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                var historicalColumnTill = PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.HistoricalTimeStep - 1;
                var lastHistoricalColumnLetter = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, historicalColumnTill);
                var forecastColumnTill = PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.TotalTimeStep;
                var showColumnTill = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, forecastColumnTill - 1);
                var hideColumnFrom = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, forecastColumnTill);        

                sheet.Shapes("Picture 16").Visible = 0;
                sheet.Shapes("shp_Advanced_Trends").Visible = -1;
                sheet.Shapes("shp_Advanced_Price_O").Visible = -1;
                sheet.Shapes("shp_Advanced_Price_PS").Visible = 0;
                sheet.Shapes("shp_Advanced_Price_GTN").Visible = 0;
                //sheet.Shapes("shp_Advanced_Price_Split").Visible = 0;
                //sheet.Shapes("shp_Advanced_Price_Split_P").Visible = 0;
                //sheet.Shapes("shp_Advanced_Price_Split_G2").Visible = 0;
                //sheet.Shapes("shp_Advanced_Price_Split_PGTN").Visible = -1;
                sheet.Shapes("TxtEvents").Visible = -1;
                sheet.Shapes("drp_Dwn_Events").Visible = -1;
                sheet.Shapes("TxtPacks").Visible = -1;
                sheet.Shapes("drpDwn_Packs").Visible = -1;
                if (PHARMAACE.FORECASTAPP.GENERICS.getSkuCount() > 0) {
                    if (PHARMAACE.FORECASTAPP.GENERICS.isTotalSku()) {
                        hideshowRows(sheet, 11, 260, true);
                        hideshowRows(sheet, 255, 260, false);
                        //sheet.Range("A11:A260").EntireRow.Hidden = true;
                        //sheet.Range("A255:A260").EntireRow.Hidden = false;

                        sheet.Shapes("shp_Advanced_Trends").Visible = 0;
                        sheet.Shapes("shp_Advanced_Price_O").Visible = 0;
                        sheet.Shapes("shp_Advanced_Price_PS").Visible = 0;
                        sheet.Shapes("shp_Advanced_Price_GTN").Visible = 0;
                        sheet.Shapes("shp_Advanced_Price_Split").Visible = 0;
                        sheet.Shapes("shp_Advanced_Price_Split_P").Visible = 0;
                        sheet.Shapes("shp_Advanced_Price_Split_G2").Visible = 0;
                        sheet.Shapes("shp_Advanced_Price_Split_PGTN").Visible = 0;
                        sheet.Shapes("TxtPacks").Visible = 0;
                        sheet.Shapes("drpDwn_Packs").Visible = 0;
                        sheet.Shapes("TxtEvents").Visible = 0;
                        sheet.Shapes("drp_Dwn_Events").Visible = 0;
                        var rng1 = sheet.Range("G256:{1}259".replace("{1}", lastHistoricalColumnLetter));
                        rng1.Formula = "=SUMIFS(ForecastData!F:F,ForecastData!$A:$A,Vars!$P$2,ForecastData!$C:$C,Vars!$P$4,ForecastData!$E:$E,$F256)";
                        rng1.Value = rng1.Value;
            
                        var rng2 = sheet.Range("G260:{1}260".replace("{1}", lastHistoricalColumnLetter));
                        rng2.Formula = "=IFERROR(G259/G257,0)";
                        rng2.Value = rng2.Value;
                    }
                    else {
                        hideshowRows(sheet, 256, 260, true);
                        //sheet.Range("A256:A260").EntireRow.Hidden = true;
                        sheet.Shapes("Picture 16").Visible = -1;
                    }
                }
            }

            PHARMAACE.FORECASTAPP.GENERICS.Create_BDL_Pipeline_Volume = function () {
                PHARMAACE.FORECASTAPP.GENERICS.BDL_Pipeline_Hide_Unhide();
                PHARMAACE.FORECASTAPP.GENERICS.BDL_Pipeline_Formula();
            }

            PHARMAACE.FORECASTAPP.GENERICS.Create_BDL_Inline_Volume = function () {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                hideshowRows(sheet, 6, 7, true);
                //sheet.Range("A6:A7").EntireRow.Hidden = true;
                PHARMAACE.FORECASTAPP.GENERICS.BDL_Inline_Hide_Unhide();
                PHARMAACE.FORECASTAPP.GENERICS.BDL_Inline_Formula();
            }

            PHARMAACE.FORECASTAPP.GENERICS.BDL_Inline_Formula = function () {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                sheet.Range("G29:NB29").Formula = "=SUM(G$14:G$28)";
                sheet.Range("G47:NB47").Formula = "=SUM(G$32:G$46)";
                sheet.Range("G65:NB65").Formula = "=SUM(G$50:G$64)";
                sheet.Range("G85:NB85").Formula = "=SUM(G$70:G$84)";
                sheet.Range("G114:NB114").Formula = '=IF(G$10<$J113,G67,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,"Monthly"))';
                sheet.Range("G144:NB144").Formula = '=IFERROR((((((((((G115*(1+G133))*(1+G134))*(1+G135))*(1+G136))*(1+G137))*(1+G138))*(1+G139))*(1+G140))*(1+G141))*(1+G142),0)';
                sheet.Range("G29:NB29").Interior.Color = 16777215;
                sheet.Range("G47:NB47").Interior.Color = 16777215;
                sheet.Range("G65:NB65").Interior.Color = 16777215;
                sheet.Range("G85:NB85").Interior.Color = 16777215;
                hideshowRows(sheet, 47, 47, true);
                //sheet.Range("A47:A47").EntireRow.Hidden = true;
            }

            PHARMAACE.FORECASTAPP.GENERICS.BDL_Inline_Hide_Unhide = function () {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                var historicalColumnTill = PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.HistoricalTimeStep - 1;
                var lastHistoricalColumnLetter = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, historicalColumnTill);
                var forecastColumnTill = PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.TotalTimeStep;
                var showColumnTill = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, forecastColumnTill - 1);
                var hideColumnFrom = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, forecastColumnTill);
                var productIndex = document.getElementById('selectProduct').selectedIndex;
                var skuIndex = document.getElementById('selectSKU').selectedIndex;
                var scenarioIndex = document.getElementById('selectScenario').selectedIndex;

                hideshowRows(sheet, 13, 260, false);
                hideshowRows(sheet, 13, 86, true);
                //sheet.Range("A13:A260").EntireRow.Hidden = false;
                //sheet.Range("A13:A86").EntireRow.Hidden = true;
                sheet.Range("G50:NB64").Interior.Color = 16777215;
                sheet.Range("G14:NB28").Interior.Color = 16777215;
                sheet.Range("G70:NB84").Interior.Color = 16777215;

                var competitorCount = PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].Competitors.length;
                if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.DataType == 0) //Units
                {
                    hideshowRows(sheet, 49, 49 + competitorCount, false);
                    hideshowRows(sheet, 65, 68, false);
                    hideshowRows(sheet, 69, 69 + competitorCount, false);
                    hideshowRows(sheet, 85, 88, false);
                    //sheet.Range("{0}:{1}".replace("{0}", 49).replace("{1}", 49 + competitorCount)).EntireRow.Hidden = false;
                    //sheet.Range("A65:A68").EntireRow.Hidden = false;
                    //sheet.Range("A69:A{1}".replace("{1}", competitorCount + 69)).EntireRow.Hidden = false;
                    //sheet.Range("A85:A88").EntireRow.Hidden = false;
                    sheet.Range("F65").Value = "Total Market";
                    sheet.Range("F65").Interior.Color = 16777215;
                    sheet.Range("F50:F64").Interior.Color = 13434879;
                    sheet.Range("F70:F84").Formula = '=IF(F50="","",F50)';
                    sheet.Range("G14:{1}28".replace("{1}", lastHistoricalColumnLetter)).Interior.Color = 13434879;
                    sheet.Range("G50:{1}64".replace("{1}", lastHistoricalColumnLetter)).Interior.Color = 13434879;
                    sheet.Range("G70:{1}84".replace("{1}", lastHistoricalColumnLetter)).Interior.Color = 13434879;
                }
                else { //TRx
                    hideshowRows(sheet, 13, 13 + competitorCount, false);
                    hideshowRows(sheet, 29, 30, false);
                    hideshowRows(sheet, 31, 31 + competitorCount, false);
                    hideshowRows(sheet, 47, 48, false);
                    hideshowRows(sheet, 49, 49 + competitorCount, false);
                    hideshowRows(sheet, 65, 68, false);
                    hideshowRows(sheet, 69, 69 + competitorCount, false);
                    hideshowRows(sheet, 85, 86, false);
                    //sheet.Range("{0}:{1}".replace("{0}", 13).replace("{1}", competitorCount + 13)).EntireRow.Hidden = false;
                    //sheet.Range("A29:A30").EntireRow.Hidden = false;
                    //sheet.Range("{0}:{1}".replace("{0}", 31).replace("{1}", competitorCount + 31)).EntireRow.Hidden = false;
                    //sheet.Range("A47:A48").EntireRow.Hidden = false;
                    //sheet.Range("{0}:{1}".replace("{0}", 49).replace("{1}", competitorCount + 49)).EntireRow.Hidden = false;
                    //sheet.Range("A65:A68").EntireRow.Hidden = false;
                    //sheet.Range("{0}:{1}".replace("{0}", 69).replace("{1}", competitorCount + 69)).EntireRow.Hidden = false;
                    //sheet.Range("A85:A86").EntireRow.Hidden = false;
                    objExcel.Union(sheet.Range("G29:NB29"), sheet.Range("G47:NB47")).ClearContents();
                    //sheet.Range("G29:NB29").ClearContents();
                    //sheet.Range("G47:NB47").ClearContents();
                    sheet.Range("F32:F46").Formula = '=IF(F14="","",F14)';
                    sheet.Range("F70:F84").Formula = '=IF(F50="","",F50)';
                    sheet.Range("G50:NB65").Formula = "=G14*G32";
                    sheet.Range("F50:F64").Formula = '=IF(F32="","",F32)';

                    sheet.Range("G14:{1}28".replace("{1}", lastHistoricalColumnLetter)).Interior.Color = 13434879;
                    sheet.Range("F50:NB65").Interior.Color = 16777215;
                    sheet.Range("G47:NB47").Interior.Color = 16777215;
                    sheet.Range("G70:{1}84".replace("{1}", lastHistoricalColumnLetter)).Interior.Color = 13434879;
                }

                sheet.Range("F65").Value = "Total Market Units";
                sheet.Range("F29").Value = "Total Market";
                sheet.Range("F47").Value = "Total Market";
                sheet.Range("F85").Value = "Total Market Revenue";
                hideshowRows(sheet, 92, 109, true);
                hideshowRows(sheet, 120, 144, true);
                hideshowRows(sheet, 171, 260, true);
                //sheet.Range("A92:A109").EntireRow.Hidden = true;
                //sheet.Range("A120:A144").EntireRow.Hidden = true;
                //sheet.Range("A171:A260").EntireRow.Hidden = true;
                sheet.Range("G29:NB29").Interior.Color = 16777215;
                sheet.Range("G65:NB65").Interior.Color = 16777215;
                sheet.Range("G85:NB85").Interior.Color = 16777215;
            }

            PHARMAACE.FORECASTAPP.GENERICS.BDL_Pipeline_Formula = function () {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                sheet.Range("G29:NB29").Formula = "=SUM(G$14:G$28)";
                sheet.Range("G47:NB47").Formula = "=SUM(G$32:G$46)";
                sheet.Range("G65:NB65").Formula = "=SUM(G$50:G$64)";
                sheet.Range("G85:NB85").Formula = "=SUM(G$70:G$84)";
                sheet.Range("G114:NB114").Formula = '=IF(G$10<$J113,0,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,"Monthly"))';
                sheet.Range("F32:F46").Formula = '=IF(F14="","",F14)';
                sheet.Range("F70:F84").Formula = '=IF(F50="","",F50)';
                hideshowRows(sheet, 47, 47, true);
                //sheet.Range("A47:A47").EntireRow.Hidden = true;
                arrWhiteRanges.push("G29:NB29");
                arrWhiteRanges.push("G47:NB47");
                arrWhiteRanges.push("G85:NB85");
                //sheet.Range("G29:NB29").Interior.Color = 16777215;
                //sheet.Range("G47:NB47").Interior.Color = 16777215;
                //sheet.Range("G85:NB85").Interior.Color = 16777215;
                sheet.Range("G144:NB144").Formula = "=G142*G108";
            }

            PHARMAACE.FORECASTAPP.GENERICS.BDL_Pipeline_Hide_Unhide = function () {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                var historicalColumnTill = PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.HistoricalTimeStep - 1;
                var lastHistoricalColumnLetter = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, historicalColumnTill);
                var forecastColumnTill = PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.TotalTimeStep;
                var showColumnTill = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, forecastColumnTill - 1);
                var hideColumnFrom = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, forecastColumnTill);

                hideshowRows(sheet, 11, 260, false);
                //sheet.Range("A11:A260").EntireRow.Hidden = false;
                hideshowRows(sheet, 13, 86, true);
                //sheet.Range("A13:A86").EntireRow.Hidden = true;

                var competitorCount = PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey].Competitors.length;
                if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.DataType == 0) //Units
                {
                    hideshowRows(sheet, 49, 49 + competitorCount, false);
                    hideshowRows(sheet, 65, 68, false);
                    hideshowRows(sheet, 69, 69 + competitorCount, false);
                    hideshowRows(sheet, 85, 88, false);
                    //sheet.Range("{0}:{1}".replace("{0}", 49).replace("{1}", 49 + competitorCount)).EntireRow.Hidden = false;
                    //sheet.Range("A65:A68").EntireRow.Hidden = false;
                    //sheet.Range("A69:A{1}".replace("{1}", competitorCount + 69)).EntireRow.Hidden = false;
                    //sheet.Range("A85:A88").EntireRow.Hidden = false;
                    arrYellowRanges.push("F50:{1}64".replace("{1}", lastHistoricalColumnLetter));
                    //sheet.Range("F50:{1}64".replace("{1}", lastHistoricalColumnLetter)).Interior.Color = 13434879;
                    arrWhiteRanges.push("F65:NB65");
                    //sheet.Range("F65:NB65").Interior.Color = 16777215;
                }
                else { //TRx
                    hideshowRows(sheet, 13, 13 + competitorCount, false);
                    hideshowRows(sheet, 29, 30, false);
                    hideshowRows(sheet, 31, 31 + competitorCount, false);
                    hideshowRows(sheet, 47, 48, false);
                    hideshowRows(sheet, 49, 49 + competitorCount, false);
                    hideshowRows(sheet, 65, 68, false);
                    hideshowRows(sheet, 69, 69 + competitorCount, false);
                    hideshowRows(sheet, 85, 86, false);
                    //sheet.Range("{0}:{1}".replace("{0}", 13).replace("{1}", competitorCount + 13)).EntireRow.Hidden = false;
                    //sheet.Range("A29:A30").EntireRow.Hidden = false;
                    //sheet.Range("{0}:{1}".replace("{0}", 31).replace("{1}", competitorCount + 31)).EntireRow.Hidden = false;
                    //sheet.Range("A47:A48").EntireRow.Hidden = false;
                    //sheet.Range("{0}:{1}".replace("{0}", 49).replace("{1}", competitorCount + 49)).EntireRow.Hidden = false;
                    //sheet.Range("A65:A68").EntireRow.Hidden = false;
                    //sheet.Range("{0}:{1}".replace("{0}", 69).replace("{1}", competitorCount + 69)).EntireRow.Hidden = false;
                    //sheet.Range("A85:A86").EntireRow.Hidden = false;
                    sheet.Range("F50:F64").Formula = '=IF(F32="","",F32)';
                    sheet.Range("G50:NB64").Formula = "=G14*G32";
                    arrWhiteRanges.push("F50:NB65");
                    //sheet.Range("F50:NB65").Interior.Color = 16777215;
                    arrYellowRanges.push("G14:{1}28".replace("{1}", lastHistoricalColumnLetter));
                    arrYellowRanges.push("G70:{1}84".replace("{1}", lastHistoricalColumnLetter));
                    //sheet.Range("G14:{1}28".replace("{1}", lastHistoricalColumnLetter)).Interior.Color = 13434879;
                    //sheet.Range("G70:{1}84".replace("{1}", lastHistoricalColumnLetter)).Interior.Color = 13434879;
                }

                hideshowRows(sheet, 66, 67, true);
                hideshowRows(sheet, 86, 87, true);
                hideshowRows(sheet, 90, 90, true);
                //sheet.Range("A66:A67").EntireRow.Hidden = true;
                //sheet.Range("A86:A87").EntireRow.Hidden = true;
                //sheet.Range("A90:A90").EntireRow.Hidden = true;
                sheet.Range("F65").Value = "Total Market Units";
                sheet.Range("F29").Value = "Total Market TRx";
                sheet.Range("F85").Value = "Total Market Revenue";
                hideshowRows(sheet, 120, 145, true);
                hideshowRows(sheet, 171, 260, true);
                hideshowRows(sheet, 92, 92, true);
                //sheet.Range("A120:A145").EntireRow.Hidden = true;
                //sheet.Range("A171:A260").EntireRow.Hidden = true;
                //sheet.Range("A92:A92").EntireRow.Hidden = true;
                hideshowRows(sheet, 110, 110, false);
                //sheet.Range("A110:A110").EntireRow.Hidden = false;
            }

            PHARMAACE.FORECASTAPP.GENERICS.populateHistoricalData = function (historicalData) {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;                
                var competitorsRetrieved = false;
                for (var i = 0; i < historicalData.length; i++) {
                    var hd = historicalData[i];
                    if (hd.Parameter.Scope == 1) //Forecast
                        sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                    else if (hd.Parameter.Scope == 2) //Trending
                        sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Trending;
                    else if (hd.Parameter.Scope == 3) //Price
                        sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Price;
                    sheet.Range("F{0}:NB{1}".replace("{0}", hd.Parameter.StartRow).replace("{1}", hd.Parameter.StartRow + hd.Transactions.length - 1)).ClearContents();
                    var arr = [];
                    var hdtMaxLength = 0;
                    var datapointArrs = [];
                    //find max length of transactions
                    for (var j = 0; j < hd.Transactions.length; j++) {
                        var hdt = hd.Transactions[j];
                        var datapointArr = [];
                        datapointArr[0] = hdt.Competitor;
                        //extend the arr till data start
                        if (hdt.DataStartFrom > 1)
                            datapointArr[hdt.DataStartFrom - 1] = undefined;
                        datapointArr = datapointArr.concat(hdt.Transactions);
                        if (datapointArr.length > hdtMaxLength)
                            hdtMaxLength = datapointArr.length;
                        datapointArrs[j] = datapointArr;
                    }
                    //adjust lengths to make it a rectangle and create the vbarray
                    for (var j = 0; j < datapointArrs.length; j++) {                        
                        //populate undefined tail
                        if (!datapointArrs[j][hdtMaxLength - 1])
                            datapointArrs[j][hdtMaxLength - 1] = undefined;
                        arr.push(datapointArrs[j].toVBArray());
                    }
                    
                    var leftTop = "F" + hd.Parameter.StartRow;
                    var lasthdColumn = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_COMPETITOR_COLUMN + datapointArrs[0].length - 1);
                    var rightBottom = lasthdColumn + (hd.Parameter.StartRow + arr.length - 1).toString();
                    PHARMAACE.FORECASTAPP.UTILITY.setRectangularRangeValue(objExcel, sheet, leftTop, rightBottom, arr);
                }
            }
            //PHARMAACE.FORECASTAPP.GENERICS.populateHistoricalData = function (historicalData) {
            //    var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
            //    var competitorsRetrieved = false;
            //    for (var i = 0; i < historicalData.length; i++) {
            //        var hd = historicalData[i];
            //        if (hd.Parameter.Scope == 1) //Forecast
            //            sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
            //        else if (hd.Parameter.Scope == 2) //Trending
            //            sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Trending;
            //        else if (hd.Parameter.Scope == 3) //Price
            //            sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Price;
            //        sheet.Range("F{0}:NB{1}".replace("{0}", hd.Parameter.StartRow).replace("{1}", hd.Parameter.StartRow + hd.Transactions.length - 1)).ClearContents();
            //        for (var j = 0; j < hd.Transactions.length; j++) {
            //            var hdt = hd.Transactions[j];
            //            sheet.Cells(hd.Parameter.StartRow + j, PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_COMPETITOR_COLUMN).Value = hdt.Competitor;
            //            var v = hdt.Transactions.toVBArray();
            //            var leftTop = sheet.Cells(hd.Parameter.StartRow + j, PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + hdt.DataStartFrom - 1);
            //            var rightBottom = sheet.Cells(hd.Parameter.StartRow + j, PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + hdt.DataStartFrom - 1 + hdt.Transactions.length - 1);
            //            sheet.Range(leftTop, rightBottom).Value = v;
            //        }
            //    }
            //}

            PHARMAACE.FORECASTAPP.GENERICS.populateOutputData = function (outputData) {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                for (var j = 0; j < outputData.length; j++) {
                    var fdt = outputData[j];
                    if (!fdt.Parameter.StartRow || !fdt.DataStartFrom)
                        continue;
                    //hdt.Transactions.unshift(hdt.Competitor);
                    //sheet.Cells(hd.Parameter.StartRow + j, PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_COMPETITOR_COLUMN).Value = hdt.Competitor;
                    var v = fdt.Transactions.toVBArray();
                    var leftTop = sheet.Cells(fdt.Parameter.StartRow, PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + fdt.DataStartFrom - 1);
                    var rightBottom = sheet.Cells(fdt.Parameter.StartRow, PHARMAACE.FORECASTAPP.CONSTANTS.GENERIC_FORECAST_DATA_START_COLUMN + fdt.DataStartFrom - 1 + fdt.Transactions.length - 1);
                    sheet.Range(leftTop, rightBottom).Value = v;
                }
            }

            PHARMAACE.FORECASTAPP.GENERICS.populateEventData = function (forecastEventSections) {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                var startRow, columnOffset;                
                for (var j = 0; j < forecastEventSections.length; j++) {
                    var arrEvents = [];
                    if (forecastEventSections[j].Section == 3) {
                        startRow = 95;
                        columnOffset = 6;
                    }
                    if (forecastEventSections[j].Section == 2) {
                        startRow = 113;
                        columnOffset = 6;
                    }
                    if (forecastEventSections[j].Section == 1) {
                        startRow = 121;
                        columnOffset = 6;
                    }
                    
                    for (var i = 0; i < forecastEventSections[j].Events.length; i++) {
                        var arrEvent = []; 
                        var startCol = 1;
                        var event = forecastEventSections[j].Events[i];
                        if (!event.Name)
                            continue;
                        arrEvent[startCol] = event.Name;
                        startCol++
                        if (forecastEventSections[j].Section != 2) //skip status and ImpactType for Penetration
                        {
                            if (event.Status != null)
                                arrEvent[startCol] = event.Status == true ? "On" : "Off";
                            startCol++;
                            if (event.ImpactType > 0) //not null
                                arrEvent[startCol] = event.ImpactType == 1 ? "Negative" : "Positive";
                            startCol++;
                        }
                        if (event.UptakeCurve || event.UptakeCurve == 0)
                            arrEvent[startCol] = event.UptakeCurve;
                        startCol++;
                        if (event.StartShare || event.StartShare == 0)
                            arrEvent[startCol] = event.StartShare;
                        startCol++;
                        if (event.PeakShare || event.PeakShare == 0)
                            arrEvent[startCol] = event.PeakShare;
                        startCol++;
                        if (event.LaunchDate)
                            arrEvent[startCol] = event.LaunchDate;
                        startCol++;
                        if (event.MonthsToPeak || event.MonthsToPeak == 0)
                            arrEvent[startCol] = event.MonthsToPeak;
                        startCol++;

                        //maintan the rectangular shape
                        if (arrEvent.length < startCol + 1)
                            arrEvent[startCol] = undefined;

                        arrEvents[i] = arrEvent.toVBArray();
                    }
                    var leftTop = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, columnOffset - 1) + startRow;
                    var rightBottom = PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex(sheet, columnOffset - 1 + startCol - 1) + (startRow + forecastEventSections[j].Events.length - 1).toString();
                    PHARMAACE.FORECASTAPP.UTILITY.setRectangularRangeValue(objExcel, sheet, leftTop, rightBottom, arrEvents);
                }
            }

            //PHARMAACE.FORECASTAPP.GENERICS.populateEventData = function (forecastEventSections) {
            //    var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
            //    var startRow, startCol;
            //    for (var j = 0; j < forecastEventSections.length; j++) {
            //        if (forecastEventSections[j].Section == 3) {
            //            startRow = 95;
            //            startCol = 6;
            //        }
            //        if (forecastEventSections[j].Section == 2) {
            //            startRow = 113;
            //            startCol = 6;
            //        }
            //        if (forecastEventSections[j].Section == 1) {
            //            startRow = 121;
            //            startCol = 6;
            //        }
            //        var columnOffset = startCol;
            //        for (var i = 0; i < forecastEventSections[j].Events.length; i++) {
            //            startCol = columnOffset;
            //            var event = forecastEventSections[j].Events[i];
            //            if (!event.Name)
            //                continue;
            //            sheet.Cells(startRow + i, startCol).Value = event.Name;
            //            startCol++;
            //            if (forecastEventSections[j].Section != 2) //skip status and ImpactType for Penetration
            //            {
            //                if (event.Status != null)
            //                    sheet.Cells(startRow + i, startCol).Value = event.Status == true ? "On" : "Off";
            //                startCol++;
            //                if (event.ImpactType > 0) //not null
            //                    sheet.Cells(startRow + i, startCol).Value = event.ImpactType == 1 ? "Negative" : "Positive";
            //                startCol++;
            //            }
            //            if (event.UptakeCurve || event.UptakeCurve == 0)
            //                sheet.Cells(startRow + i, startCol).Value = event.UptakeCurve;
            //            startCol++;
            //            if (event.StartShare || event.StartShare == 0)
            //                sheet.Cells(startRow + i, startCol).Value = event.StartShare;
            //            startCol++;
            //            if (event.PeakShare || event.PeakShare == 0)
            //                sheet.Cells(startRow + i, startCol).Value = event.PeakShare;
            //            startCol++;
            //            if (event.LaunchDate)
            //                sheet.Cells(startRow + i, startCol).Value = event.LaunchDate;
            //            startCol++;
            //            if (event.MonthsToPeak || event.MonthsToPeak == 0)
            //                sheet.Cells(startRow + i, startCol).Value = event.MonthsToPeak;
            //            startCol++;
            //        }
            //    }
            //}

            PHARMAACE.FORECASTAPP.GENERICS.Data_Clear = function () {
                var sheet = PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast;
                objExcel.Union(sheet.Range("F14:NB28"), sheet.Range("G32:NB46"), sheet.Range("G70:NB84"), sheet.Range("G113:K113"),
                    sheet.Range("G91:NB91"), sheet.Range("G150:NB150"), sheet.Range("G153:NB153"), sheet.Range("G156:NB156"),
                    sheet.Range("G172:NB186"), sheet.Range("F172:F186"), sheet.Range("G206:NB220"), sheet.Range("F121:M130"),
                    sheet.Range("G241:NB244"), sheet.Range("G70:NB85"), sheet.Range("G65:NB65"), sheet.Range("F50:NB65"), 
                    sheet.Range("F50:NB64"), sheet.Range("G29:NB29"), sheet.Range("G47:NB47"), sheet.Range("G85:NB85"), 
                    sheet.Range("G95:M99")).ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("F14:NB28").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G32:NB46").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G70:NB84").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G113:K113").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G91:NB91").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G150:NB150").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G153:NB153").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G156:NB156").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G172:NB186").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("F172:F186").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G206:NB220").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("F121:M130").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G241:NB244").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G70:NB85").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G65:NB65").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("F50:NB65").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("F50:NB64").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G29:NB29").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G47:NB47").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G85:NB85").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast.Range("G95:M99").ClearContents();

                var sheet2 = PHARMAACE.FORECASTAPP.GENERICS.wks_Trending;
                objExcel.Union(sheet2.Range("G357:M361"), sheet2.Range("G357:M361"), sheet2.Range("G34:NB48"), sheet2.Range("G333:NB341"),
                    sheet2.Range("G347:NB347")).ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Trending.Range("G357:M361").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Trending.Range("G34:NB48").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Trending.Range("G333:NB341").ClearContents();
                //PHARMAACE.FORECASTAPP.GENERICS.wks_Trending.Range("G347:NB347").ClearContents();

                PHARMAACE.FORECASTAPP.GENERICS.wks_Price.Range("G41:NB41").ClearContents();
            }

            PHARMAACE.FORECASTAPP.GENERICS.Create_Forecast_Generic = function () {
                var newForecastData = PHARMAACE.FORECASTAPP.GENERICS.populateForecastProjectVersionData();
                if (newForecastData) {
                    PHARMAACE.FORECASTAPP.GENERICS.forecastData = newForecastData;
                    PHARMAACE.FORECASTAPP.GENERICS.Application_Events_Handler(false);
                    PHARMAACE.FORECASTAPP.GENERICS.Data_Clear();
                    PHARMAACE.FORECASTAPP.GENERICS.Create_Forecast_Master();
                    PHARMAACE.FORECASTAPP.GENERICS.Application_Events_Handler(true);
                    showEDraw();
                }
                else if (isCreatedOrRetrieved)
                    showEDraw();
            }

            PHARMAACE.FORECASTAPP.GENERICS.populateForecastProjectVersionData = function () {
                var newForecastData = {
                    fv: { Scenarios: [], ForecastProducts: [] },
                    fio: {}
                };

                var projectName = $('#idProject').val();
                if (!$.trim(projectName)) //project name empty
                    return null;
                newForecastData.fv.Name = projectName;

                newForecastData.fv.Period = $('input[name="frequency"]:checked').val();

                newForecastData.fv.Category = $('input[name="category"]:checked').val();

                newForecastData.fv.DataType = $('input[name="data-type"]:checked').val();

                var historicalStartDate = $('#historical_start_date').val();
                if (!$.trim(historicalStartDate))
                    return null;
                var dtArr = historicalStartDate.split('/');
                dtArr.splice(1, 0, "01");
                newForecastData.fv.DataAvailableFrom = dtArr.join('/');

                var historicalEndDate = $('#historical_end_date').val();
                if (!$.trim(historicalEndDate))
                    return null;
                var dtArr = historicalEndDate.split('/');
                dtArr.splice(1, 0, "01");
                newForecastData.fv.DataAvailableTill = dtArr.join('/');
                var dtDataAvailableFrom = new Date(newForecastData.fv.DataAvailableFrom);
                var dtDataAvailableTill = new Date(newForecastData.fv.DataAvailableTill);
                if (dtDataAvailableFrom > dtDataAvailableTill)
                    return null;

                var forecastEndYear = $('#forecast_end_year').val();
                if (!forecastEndYear || isNaN(forecastEndYear))
                    return null;
                newForecastData.fv.ForecastYearTill = forecastEndYear;
                if (dtDataAvailableFrom.getFullYear() > forecastEndYear)
                    return null;

                newForecastData.fv.Scenarios.push({ Name: "Base", Order: 1 });
                newForecastData.fv.Scenarios.push({ Name: "Low", Order: 2 });
                newForecastData.fv.Scenarios.push({ Name: "High", Order: 3 });
                for (var i = 4; ; i++) {
                    var txtScenario = $('#scenario' + i);
                    if (txtScenario.length == 0)
                        break;
                    var addlScenario = txtScenario.val();
                    if (!$.trim(addlScenario))
                        continue;
                    newForecastData.fv.Scenarios.push({ Name: addlScenario, Order: i });
                }

                for (var i = 0; ; i++) {
                    var productNameElement = $('#addproduct{0}>td:eq(1)>input'.replace("{0}", i));
                    if (productNameElement.length == 0)
                        break;
                    var productName = productNameElement.val();
                    if (!$.trim(productName))
                        continue;

                    var isBrand = $('#addproduct{0}>td:eq(2)>div>div>input:checked'.replace("{0}", i)).length;

                    var productType = 0;
                    if ($('#addproduct{0}>td:eq(3)>div>div>div>input:eq(1):checked'.replace("{0}", i)).length == 1)
                        productType = 1;

                    var projection = 0;
                    if ($('#addproduct{0}>td:eq(5)>div>div>div>input:eq(1):checked'.replace("{0}", i)).length == 1)
                        projection = 1;

                    newForecastData.fv.HistoricalTimeStep = PHARMAACE.FORECASTAPP.GENERICS.getTimeStep(newForecastData.fv.DataAvailableTill, newForecastData.fv);
                    newForecastData.fv.TotalTimeStep = PHARMAACE.FORECASTAPP.GENERICS.getTimeStep("01/01/{0}".replace("{0}", newForecastData.fv.ForecastYearTill), newForecastData.fv);

                    var skuElements = $('#addproduct{0}>td:eq(7)>div>a>div>p>div>span'.replace("{0}", i));
                    var arrSku = [];
                    for (var j = 0; j < skuElements.length; j++) {
                        arrSku[j] = { Name: $(skuElements[j]).text(), Order: j + 1 };
                    }
                    newForecastData.fv.ForecastProducts.push({ Name: productName, Order: i + 1, Brand: isBrand, Type: productType, Projection: projection, SKUs: arrSku });

                    var competitorCount = $('#no-of-compititors0>option:selected').text(); //$('#addproduct{0}>td:eq(6)>div>button>span:eq(0)'.replace("{0}", i)).text();
                    for (var m = 0; m < arrSku.length; m++) {
                        for (var n = 0; n < newForecastData.fv.Scenarios.length; n++) {
                            var key = "{0}_{1}_{2}".replace("{0}", i).replace("{1}", m).replace("{2}", n);
                            newForecastData.fio[key] = { Competitors: [], Packs: [], HistoricalData: [], ForecastData: [], EventSections: [], Penetration: {}, PackData: [] };
                            for (var j = 0; j < competitorCount; j++) {
                                newForecastData.fio[key].Competitors.push({ Order: j + 1 });
                            }
                        }
                    }
                }
                PHARMAACE.FORECASTAPP.GENERICS.fioKey = "0_0_0";
                return newForecastData;
            }

            PHARMAACE.FORECASTAPP.GENERICS.getTimeStep = function (dt, fv) {
                var timeStep = 0;
                var dtComponents = dt.split('/');
                var month = dtComponents[0];
                var year = dtComponents[2];
                var startDtComponents = fv.DataAvailableFrom.split('/');
                var fromMonth = startDtComponents[0];
                var fromYear = startDtComponents[2];
                if (fv.Period == 1) //Monthly
                {
                    timeStep = (year - fromYear) * 12 + (month - fromMonth) + 1;
                }
                if (fv.Period == 2) //Yearly
                {
                    timeStep = (year - fromYear) + 1;
                }
                if (fv.Period == 3) //Quarterly
                {
                    timeStep = (year - fromYear) * 4 + (month - fromMonth + 1) / 3;
                }

                return timeStep;
            }

            PHARMAACE.FORECASTAPP.GENERICS.InitializeDisplay = function () {
                vbaMethod = "'{0}'!InitializeDisplay".replace("{0}", objExcel.Workbooks(1).Name);
                runMacro(vbaMethod);
                //objExcel.Workbooks(1).Activate();
                //objExcel.Workbooks(1).Worksheets("Generic_Forecast").Select();
                //objExcel.ActiveWindow.DisplayHeadings = false;
                //objExcel.ActiveWindow.DisplayWorkbookTabs = false;
                //objExcel.ActiveWindow.DisplayHorizontalScrollBar = true;
                //objExcel.ActiveWindow.DisplayVerticalScrollBar = true;
            }

            PHARMAACE.FORECASTAPP.GENERICS.FinalizeDisplay = function () {
                vbaMethod = "'{0}'!FinalizeDisplay".replace("{0}", objExcel.Workbooks(1).Name);
                runMacro(vbaMethod);
                //objExcel.Workbooks(1).Activate();
                //objExcel.Workbooks(1).Worksheets("Generic_Forecast").Select();
                //objExcel.ActiveWindow.DisplayHeadings = false;
                //objExcel.ActiveWindow.DisplayWorkbookTabs = false;
                //objExcel.ActiveWindow.DisplayHorizontalScrollBar = true;
                //objExcel.ActiveWindow.DisplayVerticalScrollBar = true;
            }

            PHARMAACE.FORECASTAPP.GENERICS.Application_Events_Handler = function (isDraw) {
                objExcel.ScreenUpdating = isDraw;
                objExcel.EnableEvents = false;
                objExcel.DisplayAlerts = isDraw;
                try {
                    if (isDraw == false)
                        objExcel.Calculation = -4135;
                    else
                        objExcel.Calculation = -4105;
                }
                catch (e) {
                    //eat exception
                }
            }


            PHARMAACE.FORECASTAPP.GENERICS.getDataByProductSkuScenario = function () {
                if (selectedProductId <= 0 || selectedSkuId <= 0 || selectedScenarioId <= 0) {
                    hideOverlay();
                    return;
                }
                PHARMAACE.FORECASTAPP.GENERICS.fioKey = "{0}_{1}_{2}".replace("{0}", document.getElementById('selectProduct').selectedIndex).replace("{1}", document.getElementById('selectProduct').selectedIndex).replace("{2}", document.getElementById('selectProduct').selectedIndex);
                if (PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey]) //already retrieved
                {
                    PHARMAACE.FORECASTAPP.GENERICS.Drop_Down_Change();
                    updateFeed();
                    hideOverlay();
                }
                else {
                    PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/Forecast/GetForecastInputOutput", JSON.stringify({ 'forecastVersionDetails': PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv, 'productId': selectedProductId, 'skuId': selectedSkuId, 'scenarioId': selectedScenarioId }),
                        function (result) {
                            if (result.success) {
                                PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey] = result.fio;
                                PHARMAACE.FORECASTAPP.GENERICS.Drop_Down_Change();
                                updateFeed();
                                hideOverlay();
                            }
                            else {
                                hideOverlay();
                            }
                        },
                        function (result) {
                            hideOverlay();
                        });
                }
            }

        }(window.PHARMAACE.FORECASTAPP.GENERICS = window.PHARMAACE.FORECASTAPP.GENERICS || {}));
    }(window.PHARMAACE.FORECASTAPP = window.PHARMAACE.FORECASTAPP || {}));
}(window.PHARMAACE = window.PHARMAACE || {}));

var arrWhiteRanges = [];
var arrYellowRanges = [];
var arrHiddenColumns = [];
var arrHiddenRows = [];

//for show and hide popup 
var hideInProgress = false;
var showModalId = '';
function showModal(elementId) {
    if (hideInProgress) {
        showModalId = elementId;
    } else {
        $("#" + elementId).modal("show");
    }
}
function hideModal(elementId) {
    hideInProgress = true;
    $("#" + elementId).on('hidden.bs.modal', hideCompleted);
    $("#" + elementId).modal("hide");
}
function hideCompleted(elementId) {
    hideInProgress = false;
    if (showModalId) {
        showModal(showModalId);
    }
    showModalId = '';
    $(elementId).off('hidden.bs.modal');
}
function delCurrentRow(numrow) {

    $("#" + (numrow)).html('');
}

$(document).ready(function () {
    
    $(".modal-body .form_wizard").clone().appendTo("#cloneid");
    
});



var hiddenRows = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false, //50
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false, //100
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false, //150
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false, //200
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false, //250
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false, //300
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false, //350
    false,
    false,
    false,
    false,
    false  //355
];

var hiddenColumns = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false, //50
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false, //100
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false, //150
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false, //200
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false, //250
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false, //300
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false, //350
    false,
    false,
    false,
    false,
    false  //355
];