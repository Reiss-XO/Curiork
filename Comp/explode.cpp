#include <iostream>
#include <fstream>
#include <cstdlib>
#include <ctime>

int main() {
    std::ofstream outFile("one_mill_recs.data");
    if (!outFile) {
        std::cerr << "Error creating file!" << std::endl;
        return 1;
    }

    std::srand(static_cast<unsigned>(std::time(nullptr)));

    for (int i = 0; i < 1000000; ++i) {
        int randomNumber = std::rand() % 101; // Generates number between 0 and 100
        outFile << randomNumber << "\n";
    }

    outFile.close();
    std::cout << "File created successfully with 1 million entries." << std::endl;
    return 0;
}
