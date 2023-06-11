vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ccat3z/libhdfs3
    HEAD_REF master
    REF baebde6c4cee7c70efc97f45d323a3a0878f3593
    SHA512 9a8b0d68895cd6b9f3d8b255b7238805fa9542d06237708ea394b88bdf8b961764bc0e7b176481f7040c675144cf88fd007070fbd6f867ea2503709ecf88662a
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DCMAKE_PROGRAM_PATH=${CURRENT_HOST_INSTALLED_DIR}/tools/yasm
        -DWITH_KERBEROS=on
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

file(GLOB HDFS3_SHARED_LIBS ${CURRENT_PACKAGES_DIR}/debug/lib/libhdfs3.so* ${CURRENT_PACKAGES_DIR}/lib/libhdfs3.so*)
file(REMOVE ${HDFS3_SHARED_LIBS})

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/share)
file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
FILE(INSTALL ${CMAKE_CURRENT_LIST_DIR}/libhdfs3Config.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
FILE(INSTALL ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
