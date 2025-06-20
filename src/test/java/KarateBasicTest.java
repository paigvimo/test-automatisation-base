import com.intuit.karate.junit5.Karate;

class KarateBasicTest {
    static {
        System.setProperty("karate.ssl", "true");
    }
    @Karate.Test
    Karate testBasic() {
        return Karate.run("classpath:features/character-search.feature",
                "classpath:features/character-save.feature",
                "classpath:features/character-update.feature",
                "classpath:features/character-delete.feature"
        );
    }

}
