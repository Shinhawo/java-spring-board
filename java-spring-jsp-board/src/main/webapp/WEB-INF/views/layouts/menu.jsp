          <ul class="sidebar-menu">
              <li class="menu-header">Board</li>
              <li class="nav-item dropdown{{ ' active'|is_active('^index(.*)', page)|safe }}">
                <a href="#" class="nav-link has-dropdown"><i class="fas fa-fire"></i><span>Board</span></a>
                <ul class="dropdown-menu">
                  <li{{ ' class="active"'|is_active('^index-0.html', page)|safe }}><a class="nav-link" href="index-0.html">New Post Registration</a></li>
                  <li{{ ' class="active"'|is_active('^index.html(.*)', page)|safe }}><a class="nav-link" href="index.html">My Posts</a></li>
                </ul>
              </li>
              <li class="menu-header">User</li>
              <li class="nav-item dropdown{{ ' active'|is_active('^layout-(.*)', page)|safe }}">
                <a href="#" class="nav-link has-dropdown" data-toggle="dropdown"><i class="fas fa-columns"></i> <span>Layout</span></a>
                <ul class="dropdown-menu">
                  <li{{ ' class="active"'|is_active('^layout-default(.*)', page)|safe }}><a class="nav-link" href="layout-default.html">Sign Up</a></li>
                  <li{{ ' class="active"'|is_active('^layout-default(.*)', page)|safe }}><a class="nav-link" href="layout-default.html">Log In</a></li>
                  <li{{ ' class="active"'|is_active('^layout-transparent(.*)', page)|safe }}><a class="nav-link" href="layout-transparent.html">User Information</a></li>
                  <li{{ ' class="active"'|is_active('^layout-top(.*)', page)|safe }}><a class="nav-link" href="layout-top-navigation.html">Edit User Information</a></li>
                  <li{{ ' class="active"'|is_active('^layout-top(.*)', page)|safe }}><a class="nav-link" href="layout-top-navigation.html">Log Out</a></li>
                </ul>
              </li>
             
            </ul>

