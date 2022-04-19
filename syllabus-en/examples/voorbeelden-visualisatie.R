library(tidyverse)
library(ggplot2)
# Voorbeelden bij het visualiseren van cijfermateriaal
example_file = "voorbeeld-visualisatie.csv"

# Observaties ophalen
if(file.exists(example_file)) {
  my_data <- read_csv(file = example_file)
} else {
  # Genereer data als er nog geen beschikbaar is
  my_data <- tibble(
    categorie = c(replicate(25, "A"), replicate(25, "B")),
    observatie = rnorm(n = 50, mean = 50, sd = 25)
  )
  write_csv(path = example_file, x = my_data)
}

# Voer een t-test uit
t.test(my_data$observatie ~ my_data$categorie)

# Naïeve plot van gemiddelden
ggplot(data = my_data, mapping = aes(x = categorie,
                                     fill = categorie,
                                     y = observatie)) +
  geom_bar(stat = "summary", fun.y = "mean") +
  theme(legend.position = "none")
ggsave("boxplot.png")

# Bereken gemiddelde en stdev van elke categorie
data_summary <- my_data %>%
  group_by(categorie) %>%
  summarise(mean = mean(observatie), sd = sd(observatie))
data_summary

# Errorbars van xbar - s to xbar + s
ggplot(data = data_summary, mapping = aes(x = categorie, fill = categorie)) +
  geom_bar(mapping = aes(y = mean), stat = "identity") +
  geom_errorbar(mapping = aes(ymin = mean - sd, ymax = mean + sd),
                width = 0.1) +
  theme(legend.position="none")
ggsave("barplot-errorbars.png")

# Boxplot
ggplot(data = my_data, mapping = aes(x = categorie)) +
  geom_boxplot(mapping = aes(y = observatie, color = categorie)) +
  geom_jitter(aes(y = observatie, color = categorie)) +
  coord_flip() +
  theme(legend.position="none")
ggsave("boxplot-jitter.png")

# Violin plot
ggplot(data = my_data, mapping = aes(x = categorie)) +
  geom_violin(mapping = aes(y = observatie, color = categorie)) +
  geom_jitter(aes(y = observatie, color = categorie)) +
  coord_flip() +
  theme(legend.position="none")
ggsave("violinplot.png")

# Density plot with sample means
ggplot(data = my_data, mapping = aes(color = categorie, x = observatie)) +
  geom_density() +
  geom_vline(data = data_summary,
             mapping = aes(xintercept = mean, color = categorie),
             linetype = "dashed")
ggsave("density.png")


