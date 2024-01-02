// import 'dart:async';
// import 'dart:math';


// class SnackGame {
//  final Random _random = Random();
//  int _gameScore = 0;
//  int _gridWidth = 20;
//  int _gridHeight = 20;
//  int _snakeHeadX = 10;
//  int _snakeHeadY = 10;
//  int _snakeLength = 5;
//  String _direction = 'RIGHT';
//  bool _gameOver = false;

//  void start() {
//     print('Welcome to the Nokia Snack game!');
//     print('Use WASD to control the snake.');

//     // Create the initial grid with the snake and food
//     List<List<String>> grid = _createInitialGrid();

//     // Start the game loop
//     Timer.periodic(Duration(milliseconds: 100), (Timer t) {
//       // Print the current state of the grid
//       print(_printGrid(grid));

//       // Handle the snake movement
//       _handleSnakeMovement(grid);

//       // Check if the game is over
//       if (_gameOver) {
//         print('Game Over! Your score was $_gameScore.');
//         t.cancel();
//       }
//     });
//  }

//  List<List<String>> _createInitialGrid() {
//     List<List<String>> grid = List.generate(_gridHeight, (int y) {
//       return List.generate(_gridWidth, (int x) {
//         if (x == _snakeHeadX && y == _snakeHeadY) {
//           return 'S';
//         } else if (_isFood(x, y)) {
//           return 'F';
//         } else {
//           return ' ';
//         }
//       });
//     });

//     return grid;
//  }

//  String _printGrid(List<List<String>> grid) {
//     String output = '';
//     for (List<String> row in grid) {
//       output += row.join() + '\n';
//     }
//     return output;
//  }

//  void _handleSnakeMovement(List<List<String>> grid) {
//     int newHeadX = _snakeHeadX;
//     int newHeadY = _snakeHeadY;

//     // Move the snake in the current direction
//     switch (_direction) {
//       case 'UP':
//         newHeadY--;
//         break;
//       case 'DOWN':
//         newHeadY++;
//         break;
//       case 'LEFT':
//         newHeadX--;
//         break;
//       case 'RIGHT':
//         newHeadX++;
//         break;
//     }

//     // Check for collisions with the wall or self
//     if (newHeadX < 0 || newHeadX >= _gridWidth || newHeadY < 0 || newHeadY >= _gridHeight) {
//       _gameOver = true;
//       return;
//     }

//     // Check for collisions with food
//     if (grid[newHeadY][newHeadX] == 'F') {
//       _gameScore++;
//       _snakeLength++;

//       // Replace the food with a new food location
//       while (true) {
//         int foodX = _random.nextInt(_gridWidth);
//         int foodY = _random.nextInt(_gridHeight);
//         if (grid[foodY][foodX] == ' ') {
//           grid[foodY][foodX] = 'F';
//           break;
//         }
//       }
//     }

//     // Move the snake to the new head location
//     for (int y = 0; y < _gridHeight; y++) {
//       for (int x = 0; x < _gridWidth; x++) {
//         if (grid[y][x] == 'S') {
//           grid[y][x] = ' ';
//         }
//       }
//     }

//     grid[newHeadY][newHeadX] = 'S';
//     _snakeHeadX = newHeadX;
//     _snakeHeadY = newHeadY;
//  }

//  bool _isFood(int x, int y) {
//     return grid[y][x] == 'F';
// }

// void _updateGame() {
//     if (_gameOver) {
//       _gameOver = true;
//       return;
//     }

//     // Check for collisions with food
//     if (_isFood(_snakeHeadX, _snakeHeadY)) {
//       _gameScore++;
//       _snakeLength++;

//       // Replace the food with a new food location
//       while (true) {
//         int foodX = _random.nextInt(_gridWidth);
//         int foodY = _random.nextInt(_gridHeight);
//         if (grid[foodY][foodX] == ' ') {
//           grid[foodY][foodX] = 'F';
//           break;
//         }
//       }
//     }

//     // Move the snake to the new head location
//     for (int y = 0; y < _gridHeight; y++) {
//       for (int x = 0; x < _gridWidth; x++) {
//         if (grid[y][x] == 'S') {
//           grid[y][x] = ' ';
//         }
//       }
//     }

//     grid[_snakeHeadY][_snakeHeadX] = 'S';
// }