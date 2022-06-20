#include "ball.h"

ball_object::ball_object()
{
    SDL_ball_object.x = 476;
    SDL_ball_object.y = 356;
    SDL_ball_object.h = 10;
    SDL_ball_object.w = 10;   

    direction_x = false;
    direction_y = false;
    effect_on_y = 0;
}

ball_object::ball_object(int y_value)
{
    SDL_ball_object.x = 476;
    SDL_ball_object.y = y_value;
    SDL_ball_object.h = 9;
    SDL_ball_object.w = 9;   

    direction_x = false;
    direction_y = false;
    effect_on_y = 0;
}

SDL_Rect* ball_object::getBall_pointer(){
    return &SDL_ball_object;
}

int ball_object::getX(){
    return SDL_ball_object.x;
}

int ball_object::getY(){
    return SDL_ball_object.y;
}

void ball_object::setX(int value){
    SDL_ball_object.x = value;
}

void ball_object::setY(int value){
    SDL_ball_object.y = value;
}

int ball_object::getW(){
    return SDL_ball_object.w;
}

bool ball_object::getXdirection(){
    return direction_x;
}

bool ball_object::getYdirection(){
    return direction_y;
}

void ball_object::setXdirection(bool value){
    direction_x = value;
}

void ball_object::setYdirection(bool value){
    direction_y = value;
}

int ball_object::get_effect_on_y(){
    return effect_on_y;
}

void ball_object::set_effect_on_y(int value){
    effect_on_y = value;
}

void ball_object::caclulate_effect_on_y(int value){
    if(value >= 11){
        direction_y = false;
    } 
    else if(value <= -11){
        direction_y = true;
    } 
    if(value < 0) value -= 2 * value;

    if(value >= 0 && value <= 18) effect_on_y = 1;
    else if(value > 18 && value <= 36) effect_on_y = 2;
    else if(value > 36) effect_on_y = 3;
}

ball_object& ball_object::move_x(){
    if(direction_x)
        SDL_ball_object.x++;
    else if(!direction_x)
        SDL_ball_object.x--;

    return *this;
}

ball_object& ball_object::move_y(){
    if(direction_y)
        SDL_ball_object.y += effect_on_y;
    else if(!direction_y)
        SDL_ball_object.y -= effect_on_y;

    return *this;
}

bool ball_object::is_collusion_on_x(SDL_Rect obj){
    if(direction_x){
        if(obj.x == (SDL_ball_object.x + SDL_ball_object.w) && SDL_ball_object.y >= obj.y - 7 && (SDL_ball_object.y + SDL_ball_object.h) <= (obj.y + obj.h + 7)){
            caclulate_effect_on_y(((obj.y + obj.h/2) - (SDL_ball_object.y + SDL_ball_object.h/2)));
            return true; 
        }            
    }
    else if(!direction_x){
        if((obj.x + obj.w) == SDL_ball_object.x && SDL_ball_object.y >= obj.y - 7 && (SDL_ball_object.y + SDL_ball_object.h) <= (obj.y + obj.h + 7)){
            caclulate_effect_on_y(((obj.y + obj.h/2) - (SDL_ball_object.y + SDL_ball_object.h/2)));
            return true; 
        }                    
    }
    return false;
}

bool ball_object::is_collusion_on_y(){
    if(SDL_ball_object.y > 720 - SDL_ball_object.h - 1 || SDL_ball_object.y < 1)
        return true;
    return false;
}

void ball_object::reset_ball(){
    SDL_ball_object.x = 476;
    SDL_ball_object.y = 356;

    effect_on_y = 0;
}