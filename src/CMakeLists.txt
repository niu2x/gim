find_package(FLEX REQUIRED)
flex_target(lexer lexer.l ${CMAKE_CURRENT_BINARY_DIR}/lexer.cpp)

add_executable(lua_inject_code "")
target_sources(lua_inject_code
	PRIVATE
		main.cpp
		token.cpp
		${FLEX_lexer_OUTPUTS}
)

target_include_directories(lua_inject_code 
	PRIVATE 
		${CMAKE_CURRENT_SOURCE_DIR})