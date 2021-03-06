#
#  $Id: ncurses.cmake 176322 2019-10-22 15:38:45Z david.schultz $
#  
#  Copyright (C) 2007   Troy D. Straszheim  <troy@icecube.umd.edu>
#  and the IceCube Collaboration <http://www.icecube.wisc.edu>
#  
#  This file is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>
#  

# we don't use the tooldef() macro, so we have to fudge pretty-printing
colormsg("")
colormsg(HICYAN "ncurses")

set(CURSES_NEED_NCURSES TRUE)

execute_process(COMMAND lsb_release -si OUTPUT_VARIABLE SUSE ERROR_QUIET)
if(SUSE MATCHES "^SUSE LINUX" OR SUSE MATCHES "^openSUSE")
  set(SUSE TRUE)
  colormsg(YELLOW "ncurses is broken on SUSE-like distros.")
  colormsg(YELLOW "If you need dataio-shovel, file a bug at https://code.icecube.wisc.edu/projects/icecube/newticket")
  return()
endif()
find_package(Curses)

# 
if(NOT CURSES_FOUND)

  set(NCURSES_FOUND FALSE)

else()

  set(NCURSES_FOUND TRUE)
  set(CURSES_NCURSES_INCLUDE_PATH)
  if(SUSE)
    unset(CURSES_NCURSES_INCLUDE_PATH)
    unset(CURSES_NCURSES_INCLUDE_PATH CACHE)
  endif()

  if(CURSES_HAVE_NCURSES_NCURSES_H)

    get_filename_component(CURSES_NCURSES_INCLUDE_PATH ${CURSES_HAVE_NCURSES_NCURSES_H} PATH CACHE)
    message(STATUS "+ ncurses.h found at ${CURSES_NCURSES_INCLUDE_PATH} (this should end with \"ncurses\")")
    message(STATUS "+ libncurses found at ${CURSES_NCURSES_LIBRARY}")
    set(NCURSES_INCLUDE_DIR ${CURSES_NCURSES_INCLUDE_PATH}
      CACHE STRING "Include dir for tool 'ncurses'")

  elseif(CURSES_HAVE_NCURSES_H)

    get_filename_component(CURSES_NCURSES_INCLUDE_PATH ${CURSES_HAVE_NCURSES_H} PATH CACHE)
    message(STATUS "+ ncurses.h found at ${CURSES_NCURSES_INCLUDE_PATH}")
    message(STATUS "+ libncurses found at ${CURSES_NCURSES_LIBRARY}")
    set(NCURSES_INCLUDE_DIR ${CURSES_NCURSES_INCLUDE_PATH} 
      CACHE STRING "Include dir for tool 'ncurses'")

  else(CURSES_HAVE_NCURSES_NCURSES_H)

    message(STATUS "+ ncurses.h found at ${CURSES_INCLUDE_PATH}")
    message(STATUS "+ libncurses found at ${CURSES_NCURSES_LIBRARY}")
    set(NCURSES_INCLUDE_DIR ${CURSES_INCLUDE_PATH} 
      CACHE STRING "Include dir for tool 'ncurses'")

  endif(CURSES_HAVE_NCURSES_NCURSES_H)
      
  ## setting this to CURSES_LIBRARIES includes libform
  set(NCURSES_LIBRARIES ${CURSES_LIBRARIES}
    CACHE STRING "Libraries for tool 'ncurses'")

endif(NOT CURSES_FOUND)

