import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class Assembler {
    static Map<String, String> instructionMap = new HashMap<String, String>();
    static Map<String, String> registerMap = new HashMap<String, String>();
    static String outputFileName = "output.txt";

    public static void main(String[] args) {
        ArrayList<String> instructions = new ArrayList<>();
        ArrayList<String> binaryInstructions = new ArrayList<>();
        ArrayList<String> hexadecimalInstructions = new ArrayList<>();

        setsMaps();
        // prompt the user to input the name of the inputFile
        System.out.print("Write the input file name: ");
        Scanner scanner = new Scanner(System.in);
        String inputFileName = scanner.nextLine();
        scanner.close();

        // get instructions from file
        instructions = getInstructionsFromFile(inputFileName);

        // convert assembly instructions into binary code
        for (int i = 0; i < instructions.size(); i++) {
            String binaryForm = instructionToBinary(instructions.get(i));
            binaryInstructions.add(binaryForm);
        }

        // convert binary representations into hexadecimal representation
        for (int i = 0; i < binaryInstructions.size(); i++) {
            String hexForm = binaryToHex(binaryInstructions.get(i));
            hexadecimalInstructions.add(hexForm);
        }

        // write the hexadecimal instructions into the output file
        try {
            writeToOutputFile(outputFileName, hexadecimalInstructions);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    // this method sets up the instructions and registers to use for conversions
    public static void setsMaps() {
        instructionMap.put("ADD", "0000");
        instructionMap.put("AND", "0001");
        instructionMap.put("NAND", "0010");
        instructionMap.put("NOR", "0011");
        instructionMap.put("ADDI", "0100");
        instructionMap.put("ANDI", "0101");
        instructionMap.put("LD", "0110");
        instructionMap.put("ST", "0111");
        instructionMap.put("CMP", "1000");
        instructionMap.put("JUMP", "1001");
        instructionMap.put("JE", "1010");
        instructionMap.put("JA", "1011");
        instructionMap.put("JB", "1100");
        instructionMap.put("JAE", "1101");
        instructionMap.put("JBE", "1110");

        registerMap.put("R0", "0000");
        registerMap.put("R1", "0001");
        registerMap.put("R2", "0010");
        registerMap.put("R3", "0011");
        registerMap.put("R4", "0100");
        registerMap.put("R5", "0101");
        registerMap.put("R6", "0110");
        registerMap.put("R7", "0111");
        registerMap.put("R8", "1000");
        registerMap.put("R9", "1001");
        registerMap.put("R10", "1010");
        registerMap.put("R11", "1011");
        registerMap.put("R12", "1100");
        registerMap.put("R13", "1101");
        registerMap.put("R14", "1110");
        registerMap.put("R15", "1111");
    }

    public static ArrayList<String> getInstructionsFromFile(String fileName) {
        ArrayList<String> instructionSet = new ArrayList<String>();

        try {
            File myObj = new File(fileName);
            Scanner myReader = new Scanner(myObj);
            while (myReader.hasNextLine()) {
                String data = myReader.nextLine();
                instructionSet.add(data);
            }
            myReader.close();
        } catch (FileNotFoundException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        }
        return instructionSet;
    }

    public static String toBinaryWithBitLength(int decimalNumber, int numberOfBits) {
        String binaryString = Integer.toBinaryString(decimalNumber);
        String tenBitZeroes = "0000000000";
        if (decimalNumber < 0) {
            int bitsToReduce = binaryString.length() - numberOfBits;
            binaryString = binaryString.substring(bitsToReduce);
        } else {
            int neededBits = numberOfBits - binaryString.length();
            binaryString = tenBitZeroes.substring(0, neededBits) + binaryString;
        }

        return binaryString;
    }

    public static String instructionToBinary(String instruction) {
        String operation = instruction.split("[\\s,]+")[0];

        switch (operation) {
            case "ADD":
                return add(instruction);
            case "AND":
                return and(instruction);
            case "NAND":
                return nand(instruction);
            case "NOR":
                return nor(instruction);
            case "ADDI":
                return addi(instruction);
            case "ANDI":
                return andi(instruction);
            case "LD":
                return ld(instruction);
            case "ST":
                return st(instruction);
            case "CMP":
                return cmp(instruction);
            case "JUMP":
                return jump(instruction);
            case "JE":
                return je(instruction);
            case "JA":
                return ja(instruction);
            case "JB":
                return jb(instruction);
            case "JAE":
                return jae(instruction);
            case "JBE":
                return jbe(instruction);
            default:
                return "";
        }
    }

    public static String binaryToHex(String binary) {
        int decimal = Integer.parseInt(binary, 2);
        String hexadecimal = Integer.toString(decimal, 16);

        int zeroesToAdd = 5 - hexadecimal.length();
        for (int i = 0; i < zeroesToAdd; i++) {
            hexadecimal = "0" + hexadecimal;
        }
        return hexadecimal;
    }

    public static void writeToOutputFile(String fileName, ArrayList<String> hexList) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName));) {
            writer.write("v2.0 raw\n");
            for (String hex : hexList)
                writer.write(hex + " ");
            writer.newLine();
        } catch (IOException e) {
            e.getMessage();
        }
    }

    public static String add(String instruction) {
        String[] instructionText = instruction.split("[\\s,]+");
        String opcode = instructionMap.get(instructionText[0]);
        return opcode + registerMap.get(instructionText[1]) + registerMap.get(instructionText[2])
                + "00" + registerMap.get(instructionText[3]);
    }

    public static String and(String instruction) {
        String[] instructionText = instruction.split("[\\s,]+");
        String opcode = instructionMap.get(instructionText[0]);
        return opcode + registerMap.get(instructionText[1]) + registerMap.get(instructionText[2])
                + "00" + registerMap.get(instructionText[3]);
    }

    public static String nand(String instruction) {
        String[] instructionText = instruction.split("[\\s,]+");
        String opcode = instructionMap.get(instructionText[0]);
        return opcode + registerMap.get(instructionText[1]) + registerMap.get(instructionText[2])
                + "00" + registerMap.get(instructionText[3]);
    }

    public static String nor(String instruction) {
        String[] instructionText = instruction.split("[\\s,]+");
        String opcode = instructionMap.get(instructionText[0]);
        return opcode + registerMap.get(instructionText[1]) + registerMap.get(instructionText[2])
                + "00" + registerMap.get(instructionText[3]);
    }

    public static String addi(String instruction) {
        String[] instructionArray = instruction.split("[\\s,]+");
        return instructionMap.get(instructionArray[0]) + registerMap.get(instructionArray[1])
                + registerMap.get(instructionArray[2])
                + toBinaryWithBitLength(Integer.parseInt(instructionArray[3].substring(1)), 6);
    }

    public static String andi(String instruction) {
        String[] instructionArray = instruction.split("[\\s,]+");
        return instructionMap.get(instructionArray[0]) + registerMap.get(instructionArray[1])
                + registerMap.get(instructionArray[2])
                + toBinaryWithBitLength(Integer.parseInt(instructionArray[3].substring(1)), 6);
    }

    // we're assuming that the offset will be written as a hashtag followed by a
    // number: #DEC_NUMBER, thus we'll skip the hashtag
    public static String ld(String inst) {
        String[] instructionArray = inst.split("[\\s,]+");
        return instructionMap.get(instructionArray[0]) + registerMap.get(instructionArray[1])
                + toBinaryWithBitLength(Integer.parseInt(instructionArray[2].substring(1)), 10);
    }

    public static String st(String inst) {
        String[] instructionArray = inst.split("[\\s,]+");
        return instructionMap.get(instructionArray[0]) + registerMap.get(instructionArray[1])
                + toBinaryWithBitLength(Integer.parseInt(instructionArray[2].substring(1)), 10);
    }

    public static String cmp(String inst) {
        String[] instructionArray = inst.split("[\\s,]+");
        return instructionMap.get(instructionArray[0]) + registerMap.get(instructionArray[1]) + "000000"
                + registerMap.get(instructionArray[2]);
    }

    public static String jump(String inst) {
        String[] instructionArray = inst.split("[\\s,]+");
        return instructionMap.get(instructionArray[0]) + "0000"
                + toBinaryWithBitLength(Integer.parseInt(instructionArray[1].substring(1)), 10);
    }

    public static String je(String inst) {
        String[] instructionArray = inst.split("[\\s,]+");
        return instructionMap.get(instructionArray[0]) + "0000"
                + toBinaryWithBitLength(Integer.parseInt(instructionArray[1].substring(1)), 10);
    }

    public static String ja(String inst) {
        String[] instructionArray = inst.split("[\\s,]+");
        return instructionMap.get(instructionArray[0]) + "0000"
                + toBinaryWithBitLength(Integer.parseInt(instructionArray[1].substring(1)), 10);
    }

    public static String jb(String inst) {
        String[] instructionArray = inst.split("[\\s,]+");
        return instructionMap.get(instructionArray[0]) + "0000"
                + toBinaryWithBitLength(Integer.parseInt(instructionArray[1].substring(1)), 10);
    }

    public static String jae(String inst) {
        String[] instructionArray = inst.split("[\\s,]+");
        return instructionMap.get(instructionArray[0]) + "0000"
                + toBinaryWithBitLength(Integer.parseInt(instructionArray[1].substring(1)), 10);
    }

    public static String jbe(String inst) {
        String[] instructionArray = inst.split("[\\s,]+");
        return instructionMap.get(instructionArray[0]) + "0000"
                + toBinaryWithBitLength(Integer.parseInt(instructionArray[1].substring(1)), 10);
    }
}