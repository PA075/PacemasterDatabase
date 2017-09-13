<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<header id="header">
    <nav class="navbar navbar-inverse fixed affix-top" role="banner" id="headerbar">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 ">
                    <div class="col-md-2 logo " id="">
                        <div class="pull-left left-bar">
                            <a href="<%=Url.Action("Index", "Home")%>" class="">
                                <img class="user-image img-responsive-logo" src="../../Content/img/logos.png" style="border-radius:0px;">
                            </a>
                        </div>
                    </div>
                    <div class="col-md-6 tagline" id="">
                       <h2 id="hmpage" class="kmBox21"><span class="kmBox22">PACE Homepage</span></h2>
                        <div id="beta" class="wow fadeInDown" ><div class="kmBox23">Beta</div></div>
                    </div>
                  <div class="col-md-3 "><div id="popalert" class="alert-info" style="display:none;"><span class="close" data-dismiss="alert">&times;</span><p class="kmBox24"></p></div></div>
                    <div class="col-md-1 " id="avtar">
                        <div class="pull-right top-menu">
                            <button id="btnlogin" data-title="Login Form" data-target="#loginform" data-toggle="modal" class="btn  btn-sm mubutton" type="button" >Login</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</header>