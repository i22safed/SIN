#include <time.h>
#include <iostream>
#include <sstream>
 
typedef unsigned char byte;
 
enum gameResult { FINISH, PLAY_NEW, PLAY_SAME };
enum object : byte { NOTHING, WUMPUS = 1, BAT = 2, PIT = 4, PLAYER = 8 };
 
const unsigned S_PLAYER = 0, S_WUMPUS = 1, S_BAT1 = 2, S_BAT2 = 3, S_PIT1 = 4, S_PIT2 = 5,
               MAX_ROOMS = 20, SAVED = 6, MAX_EXITS = 3, A_PATH_LEN = 5, MAX_ARROWS = 5;
 
class inOut
{
public:
    int getLetter( std::string s, int a, int b )
    {
        int c;
        do
        {
            msg( s );
            std::string r; std::cin >> r;
            std::cin.clear(); std::cin.ignore();
            c = toupper( r[0] );
        }
        while( c != a && c != b );
 
        return c;
    }
 
    int getNumber( std::string s )
    {
        int n = 0; std::string c;
        while( true ) 
        {
            msg( s );
            std::getline( std::cin, c );
            std::stringstream strm( c );
            if( strm >> n ) break;
        }
        return n;
    }
 
    void    msg( std::string s )    { std::cout << s; }
    void    msg( int i )            { std::cout << i; }
    void    wait()                  { std::cin.get(); }
};
 
class room
{
public:
    int     getExit( int i )        { return exits[i]; }
    byte    contains()              { return obj; }
    void    clear( object o )       { obj ^= o; }    
    void    clearRoom()             { obj = NOTHING; }
    void    setExit( int i, int e ) { exits[i] = e; }
    void    populate( object o )    { obj |= o; }
 
 
private:
    int exits[MAX_EXITS];
    byte obj;
};
 
class cave
{
public:
    cave()
    {
        int con[] = { 1, 4, 7, 0, 2, 9, 1, 3, 11, 2, 4, 13, 0, 3, 5, 4, 6, 14, 5, 7, 16, 0, 6, 8, 7, 9, 17, 1, 8, 10, 9, 11, 18, 
                      2, 10, 12, 11, 13, 19, 3, 12, 14, 5, 13, 15, 14, 16, 19, 6, 15, 17, 8, 16, 18, 10, 17, 19, 12, 15, 18 };
 
        for( int x = 0, r = 0; x < MAX_ROOMS; x++, r = x * MAX_EXITS )
        {
            for( unsigned c = r, d = 0; c < r + MAX_EXITS; c++, d++ )
                rooms[x].setExit( d, con[c] );    
        }
        clear();
    }
 
    void clear()
    {
        for( int x = 0; x < MAX_ROOMS; x++ )
            rooms[x].clearRoom();    
    }
 
    room* getRoom( int i ) { return &rooms[i]; }
 
private:
    room rooms[MAX_ROOMS];
};
 
class wumpus
{
private:
    inOut       inOut;
    cave        theCave;        
    unsigned    playerPos, wumpusPos, pathLen, arrowsCnt, exits[MAX_EXITS], arrowPath[A_PATH_LEN], saved[SAVED];
    bool        gameOver, playerWins;
 
    void look()
    {
        room* r = theCave.getRoom( playerPos );
        inOut.msg( "\n\n-----------------------------------\n" );
        inOut.msg( "You are in room #" ); inOut.msg( playerPos + 1 );
        inOut.msg( "\nTunnels lead to rooms #: " );
        for( int x = 0; x < MAX_EXITS; x++ )
        {
            inOut.msg( ( 1 + r->getExit( x ) ) ); 
            inOut.msg( " " );
        }
 
        lookAround( r );
    }
 
    void shoot()
    {
        room* r = theCave.getRoom( playerPos );
        unsigned e;
 
        for( unsigned x = 0; x < pathLen; x++ )
        {
            for( e = 0; e < MAX_EXITS; e++ )
                if( r->getExit( e ) == arrowPath[x] ) break;
 
            if( e < MAX_EXITS ) r = theCave.getRoom( arrowPath[x] );
            else r = theCave.getRoom( r->getExit( rand() % MAX_EXITS ) );
 
            byte o = r->contains();
 
            if( WUMPUS & o ) { gameOver = playerWins = true; return; }
            if( PLAYER & o ) 
            {
                gameOver = true; playerWins = false; 
                inOut.msg( "\n  OUCH! Arrow got you!\n" ); return;
            }
        }
 
        inOut.msg( "\n  Missed!\n\n" );
        if( --arrowsCnt == 0 )
        {
            inOut.msg( "\n  You run out of arrows...\n" );
            gameOver = true; playerWins = false;
            return;
        }
 
        wumpusMove( playerPos );
    }
 
    gameResult showResult( bool pw )
    {
        if( pw ) inOut.msg( "\n  AHA! You got the Wumpus!\n  HEE HEE HEE - The Wumpus'll getcha next time!!\n\n" );
        else inOut.msg( "  HA HA HA - You lose!\n\n" );
 
        if( inOut.getLetter( "Play again (Y/N)? ", 'Y', 'N' ) == 'Y' )
        {
            if( inOut.getLetter( "Same setup (Y/N)? ", 'Y', 'N' ) == 'Y' ) return PLAY_SAME;
            return PLAY_NEW;
        }
 
        return FINISH;
    }
 
    void lookAround( room* r )
    {
        byte msg = 0, o;
        for( int x = 0; x < MAX_EXITS; x++ )
        {
            o = theCave.getRoom( r->getExit( x ) )->contains();
            msg += ( ( WUMPUS & o ) + ( BAT & o ) + ( PIT & o ) );
        }
 
        if( msg & WUMPUS ) inOut.msg( "\nYou smell something terrible nearby." );
        if( msg & PIT    ) inOut.msg( "\nYou feel a cold wind blowing from a nearby cavern." );
        if( msg & BAT    ) inOut.msg( "\nYou hear a rustling." );
    }
 
    bool checkExits( int e )
    {
        for( int x = 0; x < MAX_EXITS; x++ )
            if( e == exits[x] ) return true;
        return false;
    }
 
    void getInput()
    {
        if( inOut.getLetter( "\n\nShoot or Move (S/M)? ", 'S', 'M' ) == 'M' )
        {
            int e = inOut.getNumber( "Where to? " ) - 1;
            if( checkExits( e ) ) setPlayer( e );
            else inOut.msg( "\nArrggh! --- You cannot go there!\n\n" );
        }
        else 
        {
            do
                pathLen = inOut.getNumber( "\nNumber of rooms (1-5)? " );
            while( pathLen < 1 || pathLen > A_PATH_LEN );
 
            for( unsigned i = 0; i < pathLen; i++ )
            {
                arrowPath[i] = inOut.getNumber( "Room #" ) - 1;
                if( i <= 1 || arrowPath[i] != arrowPath[i - 2]) continue;
                inOut.msg( "\nArrows aren't that crooked! - Please, try another room.\n\n" );
                i--;
            }
            shoot();
        }
    }
 
    void setPlayer( int pos )
    {
        if( playerPos < MAX_ROOMS ) 
            theCave.getRoom( playerPos )->clear( PLAYER );
 
        if( hazards( pos ) ) return;
 
        playerPos = pos;
        room* r = theCave.getRoom( playerPos );
        r->populate( PLAYER );
 
        for( int x = 0; x < MAX_EXITS; x++ )
            exits[x] = r->getExit( x );
    }
 
    bool hazards( int pos )
    {
        room* r = theCave.getRoom( pos );
        byte o = r->contains();
 
        if( WUMPUS & o )
        {
            inOut.msg( "\n  ...OOPS! Bumped a Wumpus!\n\n" );
            if( wumpusMove( pos ) )
            {
                inOut.msg( "\n  TSK TSK TSK - Wumpus got you!\n" );
                gameOver = true; playerWins = false;
                return true;
            }
        }
 
        if( PIT & o )
        {
            inOut.msg( "\n  YYYYIIIIEEEE!!!! Fell in pit!\n");
            gameOver = true; playerWins = false;
            return true;
        }
 
        if( BAT & o )
        {
            inOut.msg( "\n  ZAP -- Super bat snatch! Elsewhereville for you!\n\n" );
            setPlayer( rand() % MAX_ROOMS );
            return true;
        }
 
        return false;
    }
 
    bool wumpusMove( int pos )
    {
        if( rand() % 100 < 75 ) 
        {
            room* r = theCave.getRoom( wumpusPos );
            r->clear( WUMPUS );
            wumpusPos = r->getExit( rand() % MAX_EXITS );
            theCave.getRoom( wumpusPos )->populate( WUMPUS );
        }
        return ( pos == wumpusPos );
    }
 
    void initGame( gameResult gr )
    {
        inOut.msg( "\n\n\n\nHUNT THE WUMPUS\n---------------\n" );
        theCave.clear(); gameOver = false; arrowsCnt = MAX_ARROWS;
 
        if( gr == PLAY_NEW )
        {
            saved[S_PLAYER] = rand() % MAX_ROOMS;
            setPlayer( saved[S_PLAYER] );
            saved[S_BAT1] = fillRoom( BAT ); saved[S_BAT2] = fillRoom( BAT );
            saved[S_PIT1] = fillRoom( PIT ); saved[S_PIT2] = fillRoom( PIT );
            wumpusPos = saved[S_WUMPUS] = fillRoom( WUMPUS );
        }
        else
        {
            setPlayer( saved[S_PLAYER] ); wumpusPos = saved[S_WUMPUS];
            theCave.getRoom( wumpusPos )->populate( WUMPUS );
            theCave.getRoom( saved[S_BAT1] )->populate( BAT );
            theCave.getRoom( saved[S_BAT2] )->populate( BAT );
            theCave.getRoom( saved[S_PIT1] )->populate( PIT );
            theCave.getRoom( saved[S_PIT2] )->populate( PIT );
        }
    }
 
    int fillRoom( object c )
    {
        int i; room* r;
        do
        {
            i = rand() % MAX_ROOMS;
            r = theCave.getRoom( i );
        }
        while( r->contains() );
 
        r->populate( c );
        return i;
    }
 
    void printInstructions()
    {
        if( inOut.getLetter( "Instructions (Y/N)? ", 'Y', 'N' ) == 'N' ) return;
        inOut.msg( "\n\nWelcome to 'HUNT THE WUMPUS'\n\nThe Wumpus lives in a cave of 20 rooms: each room has 3 tunnels leading to\n"
                   "other rooms. (Look at a Dodecahedron to see how this works, if you don't\nknow what a dodecahedron is, ask someone)\n"
                   "\n\n HAZARDS:\n --------\n\nBottomless pits:\n----------------\nTwo rooms have bottomless pits in them.\n"
                   "If you go there, you fall into the pit and lose!\n\nSuper bats:\n-----------\nTwo other rooms have super bats.\nIf you go there, "
                   "a bat grabs you and takes you to some other room at random,\nwhich might be troublesome.\n\nWumpus:\n-------\nThe Wumpus is not "
                   "bothered by the hazards, he has sucker feet and is too big\nfor a bat to lift.\nUsually he is asleep.\nTwo things wake him up: "
                   "your entering his room or your shooting an arrow.\nIf the Wumpus wakes, he has 75% chance to move one room or 25% chance to stay\n"
                   "still.\nAfter that, if he is where you are, he eats you up and you lose!\n\nYou:\n----\nEach turn you may move or shoot a crooked arrow.\n"
                   "- Moving: you can move one room (thru one tunnel)\n- Arrows: you have 5 arrows. You lose when you run out.\n  Each arrow can go from "
                   "1 to 5 rooms, you aim by telling the computer the\n  rooms #s you want the arrow to go to.\n  If the arrow can't go that way (if no tunnel) "
                   "it moves at random to the \n  next room.\n  If the arrow hits the Wumpus: you win, if the arrow hits you: you lose.\n"
                   "\n\n WARNINGS:\n --------\nWhen you are one room away from Wumpus or any other hazard, the computer says:\nWumpus: 'You smell something "
                   "terrible nearby.'\nBat: 'You hear a rustling.'\nPit: 'You feel a cold wind blowing from a nearby cavern.'\n\n\n\nPress return to play..." );
        inOut.wait();
    }
 
public:
    void play()
    {
        playerPos = MAX_ROOMS;
        gameResult gr = PLAY_NEW;
 
        printInstructions();
 
        while( gr != FINISH )
        {
            initGame( gr );
            while( !gameOver ) { look(); getInput(); }
            gr = showResult( playerWins );
        }
    }
};
 
int main( int argc, char* argv[] )
{
    srand( static_cast<unsigned>( time( NULL ) ) );
    wumpus hw; hw.play();
    return 0;
}