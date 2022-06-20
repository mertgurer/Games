// clang++ main.cpp ./includes/ball.cpp -Iincludes ./glad/src/glad.c -o pong -I/Library/Frameworks/SDL2.framework/Headers -I./glad/include -F/Library/Frameworks -framework SDL2

#include "ball.h"
#define ball_count 5        // total number of balls in the game
#define height 720
#define width 960

using namespace std;

void setup_obj();
bool game_runner(ball_object& ball);
void reset(ball_object& ball, int& progress_counter, int& high_score, int& score_player1, int& score_ai);
void hit_detector(ball_object ball, bool& triger, int& progress_couter);
void ai_tracking(ball_object ball);
void ai_following(ball_object ball);
void button_press_check(SDL_Renderer* renderer, SDL_Surface* image, SDL_Event event, bool &game, int &screen_switch, int mouse_x, int mouse_y);
void render_start(SDL_Renderer* renderer);
void render_settings(SDL_Renderer* renderer);
void render_game(SDL_Renderer* renderer, ball_object ball_0);
void render_ball_change(SDL_Renderer* renderer);
void start_menu_textures(SDL_Renderer* renderer, SDL_Surface* image);
void settings_menu_textures(SDL_Renderer* renderer, SDL_Surface* image);
void ball_change_menu_textures(SDL_Renderer* renderer, SDL_Surface* image);
void set_ball_texture(SDL_Renderer* renderer, SDL_Surface* image, int value);

int GAME_MODE = 1;              // game mode 1 for infinete game / 2 for versus game
int MULTIPLAYER_MODE = 0;       // multiplayer game enable or disable
int DIFFICULTY = 1;             // difficulty level 1 to 3
int INPUT_METHOD = 1;           // input method 1 for mouse / 2 for keyboard
int current_ball_texture = -1;  // variable to track ball texture

SDL_Rect player1;               // create rectangle of player 1
SDL_Rect player2;               // create rectangle of player 2

SDL_Rect pause_button;          // create pause button object
SDL_Rect computer_button;       // create computer button object
SDL_Rect multiplayer_button;    // create multiplayer button object
SDL_Rect setting_button;        // create settings button object  
SDL_Rect exit_button;           // create exit button object
SDL_Rect return_button;         // create return button object 
SDL_Rect infinete_mode_button;  // create infinete mode button object 
SDL_Rect versus_mode_button;    // create versus mode button object
SDL_Rect difficulty1_button;    // create easy mode button object 
SDL_Rect difficulty2_button;    // create normal mode button object  
SDL_Rect difficulty3_button;    // create hard mode button object
SDL_Rect mouse_input_button;    // create mouse input button object
SDL_Rect keyboard_input_button; // create keyboard input button object
SDL_Rect ball_change_button;    // create ball change button
SDL_Rect ball_preview;          // ball preview square
SDL_Rect ball_go_back;          // change ball to previous
SDL_Rect ball_go_next;          // change ball to next

SDL_Texture* ball_texture;
SDL_Texture* back_texture;
SDL_Texture* next_texture;
SDL_Texture* computer_texture;
SDL_Texture* multiplayer_texture;
SDL_Texture* setting_texture;
SDL_Texture* exit_texture;
SDL_Texture* versus_mode_on_texture;
SDL_Texture* versus_mode_off_texture;
SDL_Texture* infinete_mode_on_texture;
SDL_Texture* infinete_mode_off_texture;
SDL_Texture* difficulty1_on_texture;
SDL_Texture* difficulty1_off_texture;
SDL_Texture* difficulty2_on_texture;
SDL_Texture* difficulty2_off_texture;
SDL_Texture* difficulty3_on_texture;
SDL_Texture* difficulty3_off_texture;
SDL_Texture* mouse_on_texture;
SDL_Texture* mouse_off_texture;
SDL_Texture* keyboard_on_texture;
SDL_Texture* keyboard_off_texture;
SDL_Texture* back_ball_texture;
SDL_Texture* next_ball_texture;

int main(int argc, char* argv[])
{     
    cout<< "== Pong ==" << endl;
    //////////////////////////////////
    /////// == screen setup == ///////
    //////////////////////////////////  
    SDL_Window* window = nullptr;           // create a window data type
    SDL_Renderer* renderer = nullptr;       // rendering object
    SDL_GLContext context;                  // opengl object
    SDL_Surface* image;

    SDL_Init(SDL_INIT_VIDEO);           // setup
    
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 4);           // version 4.
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 1);           // version .1
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);

    SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
    SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);    

    window = SDL_CreateWindow("Pong",       // creating actual window 
            300,                            // starting index x
            150,                            // starting index y
            width,                          // starting size x
            height,                         // starting size y
            SDL_WINDOW_SHOWN | SDL_WINDOW_OPENGL);  // flags of the window

    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    context = SDL_GL_CreateContext(window); // context is affecting windows object

    start_menu_textures(renderer, image);
    settings_menu_textures(renderer, image);
    ball_change_menu_textures(renderer, image);
    //////////////////////////////////
    /////// == screen setup == ///////
    ////////////////////////////////// 

    ////////////////////////////////
    /////// == game setup == ///////
    //////////////////////////////// 
    ball_object ball_0;

    setup_obj();
    set_ball_texture(renderer, image, 1);
    
    bool game = true, trigger;                      // variable that decides if the game is running 
    int mouse_x, mouse_y;                           // mouse position variables
    int progress_counter = 0, high_score = 0;       // infinite game counters
    int score_player1 = 0, score_ai = 0;            // versus game counters
    int screen_switch = 0;                          // variable for screens (start, settings, ball change, game)
    ////////////////////////////////
    /////// == game setup == ///////
    ////////////////////////////////  
    while(game)
    {   
        // == render graphics == //
        if(screen_switch == 0)              // start screen layout   
            render_start(renderer);        
        else if(screen_switch == 1)         // settings screen layout
            render_settings(renderer);
        else if(screen_switch == 2)         // game screen layout
            render_game(renderer, ball_0);
        else if(screen_switch == 3)         // ball change layout
            render_ball_change(renderer);     
           
        const Uint8* keyboard_state = SDL_GetKeyboardState(NULL);
        Uint32 mouse_state = SDL_GetMouseState(&mouse_x, &mouse_y);  

        SDL_Delay(2);                               // tick rate of the game   
        
        if(screen_switch == 2)
        {
            // == runs the game engine == //
            if(game_runner(ball_0))
            {
                reset(ball_0, progress_counter, high_score, score_player1, score_ai);
            }  

            // == player 2 movement ai == //
            if(GAME_MODE == 1 && MULTIPLAYER_MODE == 0)
            {
                hit_detector(ball_0, trigger, progress_counter);
                ai_tracking(ball_0);
            }
            else if(GAME_MODE == 2 && MULTIPLAYER_MODE == 0)
                ai_following(ball_0);

            // == inputs from user == //
            if((GAME_MODE == 1 || GAME_MODE == 2) && MULTIPLAYER_MODE == 0)
            {
                if(INPUT_METHOD == 1)                           // if input method is mouse gets the data and moves player 1 accordingly
                { 
                    if(mouse_y < (height - player1.h/2) && mouse_y > player1.h/2)           // avoids borders
                        player1.y = mouse_y - player1.h/2;
                }
                else if(INPUT_METHOD == 2)                      // if the input method is keyboard gets the data and moves player 1 accordingly
                {
                    if(keyboard_state[SDL_SCANCODE_UP])
                        if(player1.y > 0)                       // avoids borders
                            player1.y -= 2;
                    
                    if(keyboard_state[SDL_SCANCODE_DOWN])
                        if(player1.y < height - player2.h)      // avoids borders
                            player1.y += 2;
                }
            }

            // 2 player mode inputs  
            if(MULTIPLAYER_MODE == 1)
            {
                if(mouse_y < (height - player1.h/2) && mouse_y > player1.h/2)           // avoids borders
                    player1.y = mouse_y - player1.h/2;  

                if(keyboard_state[SDL_SCANCODE_UP])
                    if(player2.y > 0)                       // avoids borders
                        player2.y -= 2;            
                if(keyboard_state[SDL_SCANCODE_DOWN])
                    if(player2.y < height - player2.h)      // avoids borders
                        player2.y += 2;
            }
        }
        else
        {
            ball_0.reset_ball();
            ball_0.setXdirection(false);      

            player1.x = 30;
            player1.y = 308;      

            player2.x = 915;
            player2.y = 308;

            progress_counter = 0;
            score_ai = 0;
            score_player1 = 0;
        }

        SDL_Event event;       
        while(SDL_PollEvent (&event)){                  // Start our event loop takes events back to back 
            
            if(event.type == SDL_QUIT)                  // if event is pressing close
                game = false;

            button_press_check(renderer, image, event, game, screen_switch, mouse_x, mouse_y);      // checks if any of the buttons is pressed and acts on it                
        }
    }

    SDL_DestroyWindow(window);
    SDL_Quit();    

    return 0;
}

bool game_runner(ball_object& ball)
{
    ball.move_x();
    ball.move_y();

    if(ball.getXdirection())
    {
        if(ball.is_collusion_on_x(player2))
            ball.setXdirection(false);  
    }     
    else if(!(ball.getXdirection()))         
        if(ball.is_collusion_on_x(player1))
            ball.setXdirection(true);                                                   

    if(ball.getYdirection())
    {
        if(ball.is_collusion_on_y())
            ball.setYdirection(false);
    }        
    else if(!(ball.getYdirection()))
        if(ball.is_collusion_on_y())
            ball.setYdirection(true);

    if(ball.getX() == 15 || ball.getX() == width - 15 - ball.getW())
        return true;
    return false;
}

void reset(ball_object& ball, int& progress_counter, int& high_score, int& score_player1, int& score_ai)
{
    if(GAME_MODE == 1 && MULTIPLAYER_MODE == 0)
    {
        if(progress_counter > high_score) high_score = progress_counter;
        progress_counter = 0;
        cout<< "Current High Score: " << high_score << endl;

        player2.x = 915;
        player2.y = 308;
    }
    else if(GAME_MODE == 2 && MULTIPLAYER_MODE == 0)
    {
        if(ball.getX() == 15)
        {
            score_ai++;
            cout<< "Player: " << score_player1 << "         AI: " << score_ai << endl;  
            if(score_ai == 5)
            {                                                   
                cout<< "AI wins." << endl;
                score_ai = 0;
                score_player1 = 0;                        
            }
        } 
        else if(ball.getX() == width - 15 - ball.getW())
        {
            score_player1++;
            cout<< "Player: " << score_player1 << "         AI: " << score_ai << endl;  
            if(score_player1 == 5)
            {
                cout<< "PLayer wins." << endl;
                score_ai = 0;
                score_player1 = 0;
            } 
        }
    }
    else if(MULTIPLAYER_MODE == 1)
    {
        if(ball.getX() == 15)
        {
            score_ai++;
            cout<< "Player 1: " << score_player1 << "       Player 2: " << score_ai << endl;
            if(score_ai == 5)
            {                                                   
                cout<< "PLayer 2 wins." << endl;
                score_ai = 0;
                score_player1 = 0;                        
            }
        } 
        else if(ball.getX() == width - 15 - ball.getW())
        {
            score_player1++;
            cout<< "Player 1: " << score_player1 << "       Player 2: " << score_ai << endl;
            if(score_player1 == 5)
            {
                cout<< "PLayer 1 wins." << endl;
                score_ai = 0;
                score_player1 = 0;
            } 
        }         
    }
    ball.reset_ball();    
}

void hit_detector(ball_object ball, bool& trigger, int& progress_counter)
{
    if(!ball.getXdirection())
    {
        trigger = true;
    }
    if(trigger && ball.getXdirection())
    {
        trigger = false;
        cout<< "Score: " << ++progress_counter << endl;
    }    
}

void ai_tracking(ball_object ball)
{
    if(DIFFICULTY == 1)
    {
        if(ball.getYdirection() && player2.y < height - player2.h && 0 < ball.getY() - (player2.h/2 - ball.getW()/2 + 1))
            player2.y = ball.getY() - (player2.h/2 - ball.getW()/2 + 1);
        else if(!ball.getYdirection() && player2.y > 0 && height - player2.h > ball.getY() - (player2.h/2 - ball.getW()/2 - 1)) 
            player2.y = ball.getY() - (player2.h/2 - ball.getW()/2 - 1);
    }
    else if(DIFFICULTY == 2)
    {   
        if(ball.getYdirection() && player2.y < height - player2.h && 0 < ball.getY() - (player2.h/2 - ball.getW()/2 + 19))
            player2.y = ball.getY() - (player2.h/2 - ball.getW()/2 + 19);
        else if(!ball.getYdirection() && player2.y > 0 && height - player2.h > ball.getY() - (player2.h/2 - ball.getW()/2 - 19))
            player2.y = ball.getY() - (player2.h/2 - ball.getW()/2 - 19);                
    }
    else if(DIFFICULTY == 3)
    {
        if(ball.getYdirection() && player2.y < height - player2.h && 0 < ball.getY() - (player2.h/2 - ball.getW()/2 + 37))
            player2.y = ball.getY() - (player2.h/2 - ball.getW()/2 + 37);
        else if(!ball.getYdirection() && player2.y > 0 && height - player2.h > ball.getY() - (player2.h/2 - ball.getW()/2 - 37))
            player2.y = ball.getY() - (player2.h/2 - ball.getW()/2 - 37);
    }
}

void ai_following(ball_object ball)
{
    if(DIFFICULTY == 1)
    {
        if((ball.getY() - (player2.h/2 - ball.getW()/2 + 1) > player2.y) && player2.y < height - player2.h)
            player2.y++;
        else if((ball.getY() - (player2.h/2 - ball.getW()/2 - 1) < player2.y) && player2.y > 0)
            player2.y--;
    }
    if(DIFFICULTY == 2)
    {
        if((ball.getY() - (player2.h/2 - ball.getW()/2 + 2) > player2.y) && player2.y < height - player2.h)
            player2.y+=2;
        else if((ball.getY() - (player2.h/2 - ball.getW()/2 - 2) < player2.y) && player2.y > 0)
            player2.y-=2;
    }
    if(DIFFICULTY == 3)
    {
        if((ball.getY() - (player2.h/2 - ball.getW()/2 + 14) > player2.y) && player2.y < height - player2.h)
            player2.y+=2;
        else if((ball.getY() - (player2.h/2 - ball.getW()/2 - 14) < player2.y) && player2.y > 0)
            player2.y-=2;
    }   
}

void button_press_check(SDL_Renderer* renderer, SDL_Surface* image, SDL_Event event, bool &game, int &screen_switch, int mouse_x, int mouse_y)
{
    if(screen_switch == 0)              // play and setting buttons when in menu       
    {
        if(mouse_x > computer_button.x && mouse_x < (computer_button.x + computer_button.w) && mouse_y > computer_button.y && mouse_y < (computer_button.y + computer_button.h))            
        {
            SDL_SetTextureBlendMode(computer_texture, SDL_BLENDMODE_ADD);               // computer button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    screen_switch = 2;
                    MULTIPLAYER_MODE = 0;
                    SDL_SetTextureBlendMode(computer_texture, SDL_BLENDMODE_BLEND);
                }     
        }
        else
            SDL_SetTextureBlendMode(computer_texture, SDL_BLENDMODE_BLEND);

        if(mouse_x > multiplayer_button.x && mouse_x < (multiplayer_button.x + multiplayer_button.w) && mouse_y > multiplayer_button.y && mouse_y < (multiplayer_button.y + multiplayer_button.h))            
        {
            SDL_SetTextureBlendMode(multiplayer_texture, SDL_BLENDMODE_ADD);            // multiplayer button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    screen_switch = 2;
                    MULTIPLAYER_MODE = 1;
                    SDL_SetTextureBlendMode(multiplayer_texture, SDL_BLENDMODE_BLEND);
                }    
        }
        else
            SDL_SetTextureBlendMode(multiplayer_texture, SDL_BLENDMODE_BLEND);

        if(mouse_x > setting_button.x && mouse_x < (setting_button.x + setting_button.w) && mouse_y > setting_button.y && mouse_y < (setting_button.y + setting_button.h))            
        {
            SDL_SetTextureBlendMode(setting_texture, SDL_BLENDMODE_ADD);                // settings button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    screen_switch = 1;
                    SDL_SetTextureBlendMode(setting_texture, SDL_BLENDMODE_BLEND);
                }      
        }
        else
            SDL_SetTextureBlendMode(setting_texture, SDL_BLENDMODE_BLEND);

        if(mouse_x > exit_button.x && mouse_x < (exit_button.x + exit_button.w) && mouse_y > exit_button.y && mouse_y < (exit_button.y + exit_button.h))            
        {
            SDL_SetTextureBlendMode(exit_texture, SDL_BLENDMODE_ADD);                   // exit button 
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    game = false;
                    SDL_SetTextureBlendMode(exit_texture, SDL_BLENDMODE_BLEND);
                }
        }
        else
            SDL_SetTextureBlendMode(exit_texture, SDL_BLENDMODE_BLEND);
    }
    else if(screen_switch == 1)         // settings buttons when in settings
    {           
        if(mouse_x > return_button.x && mouse_x < (return_button.x + return_button.w) && mouse_y > return_button.y && mouse_y < (return_button.y + return_button.h))                
        {
            SDL_SetTextureBlendMode(back_texture, SDL_BLENDMODE_ADD);                   // back button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    screen_switch = 0;
                    SDL_SetTextureBlendMode(back_texture, SDL_BLENDMODE_BLEND);
                }
        }
        else
            SDL_SetTextureBlendMode(back_texture, SDL_BLENDMODE_BLEND);

        if(mouse_x > infinete_mode_button.x && mouse_x < (infinete_mode_button.x + infinete_mode_button.w) && mouse_y > infinete_mode_button.y && mouse_y < (infinete_mode_button.y + infinete_mode_button.h))           
        {
            SDL_SetTextureBlendMode(infinete_mode_off_texture, SDL_BLENDMODE_ADD);      // infinete mode button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    GAME_MODE = 1; 
                    cout<< "Game Mode Set: infinete mode" << endl;
                    SDL_SetTextureBlendMode(infinete_mode_off_texture, SDL_BLENDMODE_BLEND);
                }
        }
        else
            SDL_SetTextureBlendMode(infinete_mode_off_texture, SDL_BLENDMODE_BLEND);

        if(mouse_x > versus_mode_button.x && mouse_x < (versus_mode_button.x + versus_mode_button.w) && mouse_y > versus_mode_button.y && mouse_y < (versus_mode_button.y + versus_mode_button.h))            
        {
            SDL_SetTextureBlendMode(versus_mode_off_texture, SDL_BLENDMODE_ADD);        // versus mode button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    GAME_MODE = 2;
                    cout<< "Game Mode Set: Versus mode" << endl;
                    SDL_SetTextureBlendMode(versus_mode_off_texture, SDL_BLENDMODE_BLEND); 
                }
        }
        else
            SDL_SetTextureBlendMode(versus_mode_off_texture, SDL_BLENDMODE_BLEND);

        if(mouse_x > difficulty1_button.x && mouse_x < (difficulty1_button.x + difficulty1_button.w) && mouse_y > difficulty1_button.y && mouse_y < (difficulty1_button.y + difficulty1_button.h))            
        {
            SDL_SetTextureBlendMode(difficulty1_off_texture, SDL_BLENDMODE_ADD);        // difficulty 1 button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    DIFFICULTY = 1; 
                    cout<< "Difficulty Set: Easy" << endl;
                    SDL_SetTextureBlendMode(difficulty1_off_texture, SDL_BLENDMODE_BLEND);
                }
        }
        else
            SDL_SetTextureBlendMode(difficulty1_off_texture, SDL_BLENDMODE_BLEND);
    
        if(mouse_x > difficulty2_button.x && mouse_x < (difficulty2_button.x + difficulty2_button.w) && mouse_y > difficulty2_button.y && mouse_y < (difficulty2_button.y + difficulty2_button.h))            
        {
            SDL_SetTextureBlendMode(difficulty2_off_texture, SDL_BLENDMODE_ADD);        // difficulty 2 button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    DIFFICULTY = 2; 
                    cout<< "Difficulty Set: Normal" << endl;
                    SDL_SetTextureBlendMode(difficulty2_off_texture, SDL_BLENDMODE_BLEND);
                }
        }
        else
            SDL_SetTextureBlendMode(difficulty2_off_texture, SDL_BLENDMODE_BLEND);

        if(mouse_x > difficulty3_button.x && mouse_x < (difficulty3_button.x + difficulty3_button.w) && mouse_y > difficulty3_button.y && mouse_y < (difficulty3_button.y + difficulty3_button.h))            
        {
            SDL_SetTextureBlendMode(difficulty3_off_texture, SDL_BLENDMODE_ADD);        // difficulty 3 button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    DIFFICULTY = 3; 
                    cout<< "Difficulty Set: Hard" << endl;
                    SDL_SetTextureBlendMode(difficulty3_off_texture, SDL_BLENDMODE_BLEND);
                }
        }
        else
            SDL_SetTextureBlendMode(difficulty3_off_texture, SDL_BLENDMODE_BLEND);

        if(mouse_x > mouse_input_button.x && mouse_x < (mouse_input_button.x + mouse_input_button.w) && mouse_y > mouse_input_button.y && mouse_y < (mouse_input_button.y + mouse_input_button.h))            
        {
            SDL_SetTextureBlendMode(mouse_off_texture, SDL_BLENDMODE_ADD);              // mouse input button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    INPUT_METHOD = 1; 
                    cout<< "Controll Method Set: Mouse" << endl;
                    SDL_SetTextureBlendMode(mouse_off_texture, SDL_BLENDMODE_BLEND);

                }
        }
        else
            SDL_SetTextureBlendMode(mouse_off_texture, SDL_BLENDMODE_BLEND);

        if(mouse_x > keyboard_input_button.x && mouse_x < (keyboard_input_button.x + keyboard_input_button.w) && mouse_y > keyboard_input_button.y && mouse_y < (keyboard_input_button.y + keyboard_input_button.h))            
        {
            SDL_SetTextureBlendMode(keyboard_off_texture, SDL_BLENDMODE_ADD);           // keyboard input button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    INPUT_METHOD = 2;
                    cout<< "Controll Method Set: Keyboard" << endl;
                    SDL_SetTextureBlendMode(keyboard_off_texture, SDL_BLENDMODE_BLEND);
                }
        } 
        else
            SDL_SetTextureBlendMode(keyboard_off_texture, SDL_BLENDMODE_BLEND);

        if(mouse_x > ball_change_button.x && mouse_x < (ball_change_button.x + ball_change_button.w) && mouse_y > ball_change_button.y && mouse_y < (ball_change_button.y + ball_change_button.h))  // ball change button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                    screen_switch = 3;
    }
    else if(screen_switch == 2)        // pause button when in game
    {           
        if(mouse_x > pause_button.x && mouse_x < (pause_button.x + pause_button.w) && mouse_y > pause_button.y && mouse_y < (pause_button.y + pause_button.h))                   
        {
            SDL_SetTextureBlendMode(back_texture, SDL_BLENDMODE_ADD);                   // pause button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    screen_switch = 0;
                    SDL_SetTextureBlendMode(back_texture, SDL_BLENDMODE_BLEND);
                }           
        }
        else
            SDL_SetTextureBlendMode(back_texture, SDL_BLENDMODE_BLEND);           
    }  
    else if(screen_switch == 3)
    {
        if(mouse_x > return_button.x && mouse_x < (return_button.x + return_button.w) && mouse_y > return_button.y && mouse_y < (return_button.y + return_button.h))                
        {
            SDL_SetTextureBlendMode(back_texture, SDL_BLENDMODE_ADD);                   // back button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    screen_switch = 1;
                    SDL_SetTextureBlendMode(back_texture, SDL_BLENDMODE_BLEND);
                }
        }
        else
            SDL_SetTextureBlendMode(back_texture, SDL_BLENDMODE_BLEND);

        if(mouse_x > ball_go_next.x && mouse_x < (ball_go_next.x + ball_go_next.w) && mouse_y > ball_go_next.y && mouse_y < (ball_go_next.y + ball_go_next.h))                
        {
            SDL_SetTextureBlendMode(next_ball_texture, SDL_BLENDMODE_ADD);              // next ball button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    set_ball_texture(renderer, image, 1);
                    SDL_SetTextureBlendMode(next_ball_texture, SDL_BLENDMODE_BLEND);
                }
        }
        else
            SDL_SetTextureBlendMode(next_ball_texture, SDL_BLENDMODE_BLEND);

        if(mouse_x > ball_go_back.x && mouse_x < (ball_go_back.x + ball_go_back.w) && mouse_y > ball_go_back.y && mouse_y < (ball_go_back.y + ball_go_back.h))                
        {
            SDL_SetTextureBlendMode(back_ball_texture, SDL_BLENDMODE_ADD);              // back ball button
            if(event.type == SDL_MOUSEBUTTONDOWN)                                       // if mouse is pressed
                if(event.button.button == SDL_BUTTON_LEFT)
                {
                    set_ball_texture(renderer, image, -1);
                    SDL_SetTextureBlendMode(back_ball_texture, SDL_BLENDMODE_BLEND);
                }
        }
        else
            SDL_SetTextureBlendMode(back_ball_texture, SDL_BLENDMODE_BLEND);
    }
}

void render_start(SDL_Renderer* renderer)
{
    SDL_SetRenderDrawColor(renderer, 92, 108, 124, SDL_ALPHA_OPAQUE);   // put background color before clearing 
    SDL_RenderClear(renderer);                                          // clear canvas

    SDL_RenderCopy(renderer, computer_texture, NULL, &computer_button);
    SDL_RenderCopy(renderer, multiplayer_texture, NULL, &multiplayer_button);
    SDL_RenderCopy(renderer, setting_texture, NULL, &setting_button);
    SDL_RenderCopy(renderer, exit_texture, NULL, &exit_button);

    SDL_RenderPresent(renderer);                                        // update canvas      
}

void render_settings(SDL_Renderer* renderer)
{
    SDL_SetRenderDrawColor(renderer, 92, 108, 124, SDL_ALPHA_OPAQUE);   // put background color before clearing 
    SDL_RenderClear(renderer);                                          // clear canvas
             
    SDL_RenderCopy(renderer, back_texture, NULL, &return_button);
    SDL_RenderCopy(renderer, ball_texture, NULL, &ball_change_button);

    if(GAME_MODE == 1)
        SDL_RenderCopy(renderer, infinete_mode_on_texture, NULL, &infinete_mode_button);    
    else
        SDL_RenderCopy(renderer, infinete_mode_off_texture, NULL, &infinete_mode_button); 
    if(GAME_MODE == 2)     
        SDL_RenderCopy(renderer, versus_mode_on_texture, NULL, &versus_mode_button);
    else
        SDL_RenderCopy(renderer, versus_mode_off_texture, NULL, &versus_mode_button);
    
    if(DIFFICULTY == 1)        
        SDL_RenderCopy(renderer, difficulty1_on_texture, NULL, &difficulty1_button);
    else
        SDL_RenderCopy(renderer, difficulty1_off_texture, NULL, &difficulty1_button);
    if(DIFFICULTY == 2)        
        SDL_RenderCopy(renderer, difficulty2_on_texture, NULL, &difficulty2_button);
    else
        SDL_RenderCopy(renderer, difficulty2_off_texture, NULL, &difficulty2_button);
    if(DIFFICULTY == 3)        
        SDL_RenderCopy(renderer, difficulty3_on_texture, NULL, &difficulty3_button);
    else
        SDL_RenderCopy(renderer, difficulty3_off_texture, NULL, &difficulty3_button);   
    
    if(INPUT_METHOD == 1)        
        SDL_RenderCopy(renderer, mouse_on_texture, NULL, &mouse_input_button);
    else
        SDL_RenderCopy(renderer, mouse_off_texture, NULL, &mouse_input_button); 
    if(INPUT_METHOD == 2)        
        SDL_RenderCopy(renderer, keyboard_on_texture, NULL, &keyboard_input_button);
    else
        SDL_RenderCopy(renderer, keyboard_off_texture, NULL, &keyboard_input_button);   
      
    SDL_RenderPresent(renderer);                                        // update canvas
}

void render_game(SDL_Renderer* renderer, ball_object ball_0)
{
    SDL_SetRenderDrawColor(renderer, 92, 108, 124, SDL_ALPHA_OPAQUE);   // put background color before clearing 
    SDL_RenderClear(renderer);                                          // clear canvas

    SDL_RenderCopy(renderer, back_texture, NULL, &pause_button);
    SDL_RenderCopy(renderer, ball_texture, NULL, ball_0.getBall_pointer());

    SDL_SetRenderDrawColor(renderer, 255, 255, 255, SDL_ALPHA_OPAQUE);  // object color white

    SDL_RenderDrawRect(renderer, &player1);                             // rectangle of player 1 drawn
    SDL_RenderDrawRect(renderer, &player2);                             // rectangle of player 2 drawn
    SDL_RenderFillRect(renderer, &player1);                             // fill rectangles with color
    SDL_RenderFillRect(renderer, &player2);

    SDL_RenderPresent(renderer);                                        // update canvas
}

void render_ball_change(SDL_Renderer* renderer)
{
    SDL_SetRenderDrawColor(renderer, 92, 108, 124, SDL_ALPHA_OPAQUE);   // put background color before clearing 
    SDL_RenderClear(renderer);                                          // clear canvas    

    SDL_RenderCopy(renderer, back_texture, NULL, &return_button);
    SDL_RenderCopy(renderer, ball_texture, NULL, &ball_preview);
    SDL_RenderCopy(renderer, next_ball_texture, NULL, &ball_go_next);
    SDL_RenderCopy(renderer, back_ball_texture, NULL, &ball_go_back);

    SDL_RenderPresent(renderer);                                        // update canvas
}

void start_menu_textures(SDL_Renderer* renderer, SDL_Surface* image)
{
    image = SDL_LoadBMP("./images/computer.bmp");                               // computer button texture 
    computer_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/multiplayer.bmp");                            // multiplayer button texture
    multiplayer_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/setting.bmp");                                // settings button texture
    setting_texture = SDL_CreateTextureFromSurface(renderer, image);   
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/exit.bmp");                                   // exit button texture
    exit_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);
}

void settings_menu_textures(SDL_Renderer* renderer, SDL_Surface* image)
{
    image = SDL_LoadBMP("./images/back.bmp");                                 // return button texture
    back_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/next.bmp");                                 // return button texture
    next_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/infinete_mode_on.bmp");                       // infinete mode button on texture 
    infinete_mode_on_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/infinete_mode_off.bmp");                      // infinete mode button off texture
    infinete_mode_off_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/versus_mode_on.bmp");                         // versu mode button on texture
    versus_mode_on_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/versus_mode_off.bmp");                        // versus mode button off texture
    versus_mode_off_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/difficulty1_on.bmp");                         // difficulty 1 button on texture
    difficulty1_on_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/difficulty1_off.bmp");                        // difficulty 1 button off texture
    difficulty1_off_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/difficulty2_on.bmp");                         // difficulty 2 button on texture
    difficulty2_on_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/difficulty2_off.bmp");                        // difficulty 2 button off texture
    difficulty2_off_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/difficulty3_on.bmp");                         // difficulty 3 button on texture
    difficulty3_on_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/difficulty3_off.bmp");                        // difficulty 3 button off texture
    difficulty3_off_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/mouse_on.bmp");                               // mouse input button on texture
    mouse_on_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/mouse_off.bmp");                              // mouse input button off texture
    mouse_off_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/keyboard_on.bmp");                            // keyboard input button on texture
    keyboard_on_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/keyboard_off.bmp");                           // keyboard input button off texture
    keyboard_off_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);
}

void ball_change_menu_textures(SDL_Renderer* renderer, SDL_Surface* image)
{
    image = SDL_LoadBMP("./images/back_ball.bmp");                                 // return button texture
    back_ball_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    image = SDL_LoadBMP("./images/next_ball.bmp");                                 // return button texture
    next_ball_texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);
}

void set_ball_texture(SDL_Renderer* renderer, SDL_Surface* image, int value)
{
    current_ball_texture+= value;

    if(current_ball_texture == ball_count)
        current_ball_texture = 0;
    if(current_ball_texture == -1)
        current_ball_texture = ball_count - 1;

    if(current_ball_texture == 0)
    {
        image = SDL_LoadBMP("./images/ball_0.bmp");                                   // ball texture 0
        ball_texture = SDL_CreateTextureFromSurface(renderer, image);
        SDL_FreeSurface(image);
    }
    if(current_ball_texture == 1)
    {
        image = SDL_LoadBMP("./images/ball_1.bmp");                                   // ball texture 1
        ball_texture = SDL_CreateTextureFromSurface(renderer, image);
        SDL_FreeSurface(image);
    }
    if(current_ball_texture == 2)
    {
        image = SDL_LoadBMP("./images/ball_2.bmp");                                   // ball texture 2
        ball_texture = SDL_CreateTextureFromSurface(renderer, image);
        SDL_FreeSurface(image);
    }
    if(current_ball_texture == 3)
    {
        image = SDL_LoadBMP("./images/ball_3.bmp");                                   // ball texture 3
        ball_texture = SDL_CreateTextureFromSurface(renderer, image);
        SDL_FreeSurface(image);
    }
    if(current_ball_texture == 4)
    {
        image = SDL_LoadBMP("./images/ball_4.bmp");                                   // ball texture 4
        ball_texture = SDL_CreateTextureFromSurface(renderer, image);
        SDL_FreeSurface(image);
    }
}

void setup_obj()
{    
    player1.x = 30;
    player1.y = 308;
    player1.w = 15;
    player1.h = 105;

    player2.x = 915;
    player2.y = 308;
    player2.w = 15;
    player2.h = 105;
  
    pause_button.x = 5;
    pause_button.y = 5;
    pause_button.w = 23;
    pause_button.h = 23;

    computer_button.x = 345;
    computer_button.y = 113;
    computer_button.w = 270;
    computer_button.h = 113;

    multiplayer_button.x = 345;
    multiplayer_button.y = 240;
    multiplayer_button.w = 270;
    multiplayer_button.h = 113;

    setting_button.x = 345;
    setting_button.y = 368;
    setting_button.w = 270;
    setting_button.h = 113;

    exit_button.x = 345;
    exit_button.y = 488;
    exit_button.w = 270;
    exit_button.h = 113;

    return_button.x = 15;
    return_button.y = 15;
    return_button.w = 60;
    return_button.h = 60;

    infinete_mode_button.x = 285;
    infinete_mode_button.y = 165;
    infinete_mode_button.w = 120;
    infinete_mode_button.h = 120;

    versus_mode_button.x = 420;
    versus_mode_button.y = 165;
    versus_mode_button.w = 120;
    versus_mode_button.h = 120;
 
    difficulty1_button.x = 285;
    difficulty1_button.y = 300;
    difficulty1_button.w = 120;
    difficulty1_button.h = 120;
 
    difficulty2_button.x = 420; 
    difficulty2_button.y = 300;
    difficulty2_button.w = 120;
    difficulty2_button.h = 120;
  
    difficulty3_button.x = 555;
    difficulty3_button.y = 300;
    difficulty3_button.w = 120;
    difficulty3_button.h = 120;
 
    mouse_input_button.x = 285; 
    mouse_input_button.y = 435;
    mouse_input_button.w = 120;
    mouse_input_button.h = 120;

    keyboard_input_button.x = 420; 
    keyboard_input_button.y = 435;
    keyboard_input_button.w = 120;
    keyboard_input_button.h = 120;  

    ball_change_button.x = 885;
    ball_change_button.y = 15;
    ball_change_button.w = 60;
    ball_change_button.h = 60;

    ball_preview.x = 368;
    ball_preview.y = 248;
    ball_preview.w = 225;
    ball_preview.h = 225;   

    ball_go_next.x = 608;
    ball_go_next.y = 300;
    ball_go_next.w = 120;
    ball_go_next.h = 120; 

    ball_go_back.x = 233;
    ball_go_back.y = 300;
    ball_go_back.w = 120;
    ball_go_back.h = 120;      
}



//  09.04.2022
//  29.04.2022
//  Mert Gürer