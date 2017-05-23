package com.nda.temp;


import java.io.FileWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

public class CVSUtilExample {

    public static void main(String[] args) throws Exception {
        Random randomGenerator = new Random();
        int randomInt = randomGenerator.nextInt(100000);
        String csvFile = "c://temp//developer"+ randomInt+ ".csv";
        FileWriter fileWriter = new FileWriter(csvFile);

        List<Developer> developers = Arrays.asList(
                new Developer("mkyong", new BigDecimal(120500), 32),
                new Developer("zilap", new BigDecimal(150099), 5),
                new Developer("ultraman", new BigDecimal(99999), 99),
                new Developer("ultraman22", new BigDecimal(99999), 99)
        );

        //for header
        CSVUtils.writeLine(fileWriter, Arrays.asList("Name", "Salary", "Age"));

        for (Developer developer : developers) {

            List<String> list = new ArrayList<>();
            list.add(developer.getName());
            list.add(developer.getSalary().toString());
            list.add(String.valueOf(developer.getAge()));

            CSVUtils.writeLine(fileWriter, list);

            //try custom separator and quote.
            //CSVUtils.writeLine(writer, list, '|', '\"');
        }

        fileWriter.flush();
        fileWriter.close();

    }

}