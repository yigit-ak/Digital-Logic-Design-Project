ring binaryInstruction = instructionMap.get(instructionArray[0]) + "0000";
        return binaryInstruction + decimalToBinary(binaryInstruction, instructionArray[1]);