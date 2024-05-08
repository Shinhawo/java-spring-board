<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
          <ul class="sidebar-menu">
              <li class="menu-header">Board</li>
              <li class="nav-item dropdown{{ ' active'|is_active('^index(.*)', page)|safe }}">
 
                <a href="#" class="nav-link has-dropdown"><i class="fas fa-fire"></i><span>Board</span></a>
                <ul class="dropdown-menu">
                  <li{{ ' class="active"'|is_active('^index-0.html', page)|safe }}><a class="nav-link" href="../board/register">New Post Registration</a></li>
                  <li{{ ' class="active"'|is_active('^index.html(.*)', page)|safe }}><a class="nav-link" href="../board/list">List</a></li>
                  <li{{ ' class="active"'|is_active('^index.html(.*)', page)|safe }}><a class="nav-link" href="../user/mypost?userid=${pageContext.request.userPrincipal.name}">My Posts</a></li>
                </ul>
              </li>
              <li class="menu-header">User</li>
              <li class="nav-item dropdown{{ ' active'|is_active('^layout-(.*)', page)|safe }}">
                <a href="#" class="nav-link has-dropdown" data-toggle="dropdown"><i class="fas fa-columns"></i> <span>User</span></a>
                <ul class="dropdown-menu">
                  <sec:authorize access="isAuthenticated()">
	                  <li{{ ' class="active"'|is_active('^layout-transparent(.*)', page)|safe }}><a class="nav-link" href="../user/profile?userid=${pageContext.request.userPrincipal.name}">User Information</a></li>
    	              <li{{ ' class="active"'|is_active('^layout-top(.*)', page)|safe }}><a class="nav-link" href="../user/modify?userid=${pageContext.request.userPrincipal.name}">Edit User Information</a></li>
        	          <li{{ ' class="active"'|is_active('^layout-top(.*)', page)|safe }}><a class="nav-link" href="../customLogout">Log Out</a></li>
                  </sec:authorize> 	
                  <sec:authorize access="isAnonymous()">
                	  <li{{ ' class="active"'|is_active('^layout-default(.*)', page)|safe }}><a class="nav-link" href="../userRegister">Sign Up</a></li>
                	  <li{{ ' class="active"'|is_active('^layout-default(.*)', page)|safe }}><a class="nav-link" href="../customLogin">Log In</a></li>
                  </sec:authorize>
                </ul>
              </li>
             
            </ul>

