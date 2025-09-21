#include "lve_window.hpp"
namespace lve
{
    LveWindow::LveWindow(int width, int height, std::string windowName): width(width), height(height), windowName(windowName)
    {
        initWindow();
    }

    LveWindow::~LveWindow()
    {
        glfwDestroyWindow(window);
        glfwTerminate();
    }

    void LveWindow::initWindow()
    {
        glfwInit();
        glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API); // NO_API since we are not using openGL
        glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

        window = glfwCreateWindow(width, height, windowName.c_str(), nullptr, nullptr);
    }

}