#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/student/Documents/deliv_robot_ws/src/dynamixel_motor/dynamixel_driver"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/student/Documents/deliv_robot_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/student/Documents/deliv_robot_ws/install/lib/python2.7/dist-packages:/home/student/Documents/deliv_robot_ws/build/dynamixel_driver/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/student/Documents/deliv_robot_ws/build/dynamixel_driver" \
    "/usr/bin/python2" \
    "/home/student/Documents/deliv_robot_ws/src/dynamixel_motor/dynamixel_driver/setup.py" \
     \
    build --build-base "/home/student/Documents/deliv_robot_ws/build/dynamixel_driver" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/student/Documents/deliv_robot_ws/install" --install-scripts="/home/student/Documents/deliv_robot_ws/install/bin"