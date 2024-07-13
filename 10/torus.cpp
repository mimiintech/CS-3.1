// ----------------------------------------------------------------------
//  CS 218 -> Assignment #10
//  Torus Program, provided main.

//  Uses openGL (which must be installed).
//  openGL installation:
//	sudo apt-get update
//	sudo apt-get upgrade
//	sudo apt-get install freeglut3-dev

//  Compilation:
//	g++ -Wall -pedantic -g -c torus.cpp -lglut -lGLU -lGL -lm

#include <cstdlib>
#include <iostream>
#include <string>
#include <cmath>

#include <stdio.h>
#include <math.h>
#include <GL/gl.h>
#include <GL/glut.h>
#include <GL/freeglut.h>
#include <time.h>
#include <stdlib.h>

using	namespace	std;

// ----------------------------------------------------------------------
//  External functions (in seperate file).

extern "C" void drawTorus();
extern "C" int getParams(int, char* [], int *, int *, int *, int *, int *);

// ----------------------------------------------------------------------
//  Global variables
//	Must be globally accessible for the openGL
//	display routine, drawTorus().

float	viewAngle = 45.0;			// default view angle
float	tipAngle = 0.0;
float	tStep = 0.1;

int	radius1;				// radius 1
int	radius2;				// radius 2
int	color;					// color value

// ----------------------------------------------------------------------
//  Key handler function.
//	Updates density based on 'i' (increase) or 'd' (decrease).
//		Must limit range of step value (0.0 > tStep <= 1.0) 
//	Check for exits keys ('x', 'q', or ESC).

void	keyHandler(unsigned char key, int x, int y)
{
	if (key == 'i') {
		tStep -= 0.01;
		if (tStep <= 0.001)
			tStep = 0.01;
		glutPostRedisplay();
	}

	if (key == 'd') {
		tStep += 0.01;
		if (tStep >= 1.0)
			tStep = 1.0;
		glutPostRedisplay();
	}

	if (key == 'x' || key == 'q' || key == 27) {
		glutLeaveMainLoop();
		exit(0);
	}
}

// ----------------------------------------------------------------------
//  Key handler function (arrow keys).
//	Updates viewing angles for rotation based on arrow keys.

void	arrowHandler(int key, int x, int y)
{
	float	aStep = 5.0;

	if (key == GLUT_KEY_LEFT)
		tipAngle += aStep;

	if (key == GLUT_KEY_RIGHT)
		tipAngle -= aStep;

	if (key == GLUT_KEY_UP)
		viewAngle -= aStep;

	if (key == GLUT_KEY_DOWN)
		viewAngle += aStep;

	glutPostRedisplay();
}

// ***********************************************************************
//  Main function.
//	Get/check command line and perform openGL initializations.

int main (int argc, char * argv[]) 
{
	int	height = 0, width = 0;
	bool	paramsOK = false;
	float	viewRange = 300.0;
	float	screenRatio = 0.0;

	paramsOK = getParams(argc, argv, &radius1, &radius2,
					&height, &width, &color);

	if (paramsOK) {
		screenRatio = static_cast<float>(height) /
				static_cast<float>(width);
		if (screenRatio < 0.8 || screenRatio > 1.2) {
			cout << height << " " << width << endl;
			cout << screenRatio << endl;
			cout << "Error, invalid height/width ratio." << endl;
			paramsOK = false;
		}
	}

	// Debug call for display function
	//	drawTorus(); 

	if (paramsOK) {
		viewRange = static_cast<float>((height+width) / 4);
		glutInit(&argc, argv);
		glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
		glutInitWindowSize(height, width);
		glutInitWindowPosition(200, 200);
		glutCreateWindow("CS 218 - Torus Program");
		glClearColor(0.0, 0.0, 0.0, 0.0);

		glViewport(0, 0, height, width);
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		glOrtho(-viewRange, viewRange, -viewRange, viewRange,
						viewRange, -viewRange);
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();

		glutSpecialFunc(arrowHandler);
		glutKeyboardFunc(keyHandler);
		glutDisplayFunc(drawTorus);

		glutMainLoop();
	}

	return 0;
}

