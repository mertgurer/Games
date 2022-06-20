#include <iostream>
#include <SDL2/SDL.h>       // window interface
#include <glad/glad.h>      // opengl

#ifndef ball_H
#define ball_H

using namespace std;

class ball_object
{
    SDL_Rect SDL_ball_object;
    bool direction_x;
    bool direction_y;
    int effect_on_y;

    public:
        ball_object();
        ball_object(int y_value);

        SDL_Rect* getBall_pointer();
        int getX();
        int getY();
        void setX(int value);
        void setY(int value);
        int getW();
        bool getXdirection();
        bool getYdirection();
        void setXdirection(bool value);
        void setYdirection(bool value);
        int get_effect_on_y();
        void set_effect_on_y(int value);

        void caclulate_effect_on_y(int value);
        ball_object& move_x();
        ball_object& move_y();
        bool is_collusion_on_x(SDL_Rect obj);
        bool is_collusion_on_y();
        void reset_ball();
};

#endif