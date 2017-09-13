<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<script src="../../Scripts/custom/summernote.js"></script>
<link href="../../Content/CSS/summernote.css" rel="stylesheet" />
<div style="align-content: center; margin-left: 132px; padding-top: 117px;">


    <form>
        <div>
            <div class="col-md-2">
                <label class="control-label">Add Indication Name</label>
            </div>
            <div class="col-md-10">
                <input type="text" id="addindication" style="width: 25%" onkeypress='return event.charCode!=62 && event.charCode!=60 && event.charCode!=58 && event.charCode!=124 && event.charCode!=63 && event.charCode!=42 && event.charCode!=34 && event.charCode!=92 && event.charCode!=47' maxlength="255" required>
                <button type="submit" class="btn btn-primary" onclick="addIndication();" id="addindi" style="margin-left: 28px;">Add</button>
            </div>

        </div>
    </form>
    <form id="indicationref">
        <div>
            <div>
                <div class="col-md-2 marginbetdiv">
                    <label class="control-label">Indication Name</label>
                </div>
                <div class="col-md-10 marginbetdiv">
                    <select name="indicationname" id="indiName" onchange="fetchReference();" style="width: 25%;cursor:pointer;" required>
                        <option value="" selected="selected">Please select</option>
                        <%
                            foreach (var Indication in ViewBag.Indication)
                            { %>

                        <option value="<%=Indication%>"><%=Indication%></option>

                        <%  }
                        %>
                    </select>
                </div>
            </div>
            <div>
                <div class="col-md-2 marginbetdiv">
                    <label class="control-label">Section Name</label>
                </div>

                <div class="col-md-10 marginbetdiv">
                    <select id="sectionname" onchange="fetchReference();" style="width: 25%;cursor:pointer;" required>
                        <option value="" selected="selected">Please select</option>
                        <%
                            foreach (var section in ViewBag.Sections)
                            { %>

                        <option value="<%=section.Id%>"><%=section.SectionName%></option>

                        <%  }
                        %>
                    </select>
                </div>
            </div>
            <div>
                <div class="col-md-2 marginbetdiv">
                    <label class="control-label">Indication Reference</label>
                </div>
                <div class="col-md-10 marginbetdiv">
                    <span id="reference"></span>
                </div>
                <%--                                        <textarea style="width:50%;resize:none;border-radius: 4px;" id="reference" placeholder="Reference" required ></textarea>--%>
            </div>

            <div>
                <span class="alnRight ">
                    <button type="button" id="submitEdited" onclick="saveIndicatinReference();" class="btn btn-primary" style="margin-left: 174px;">Submit</button>
                </span>
            </div>
        </div>
    </form>
</div>
<style>
    .marginbetdiv {
        margin-top: 17px;
    }

    /*.note-editor {
        margin-right: 40px;
    }*/
</style>
<script>
    
    

</script>
