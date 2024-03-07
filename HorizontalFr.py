Python: 
class HorizontalMinitermFragmentGenerator:
    def __init__(self, predicates):
        self.predicates = predicates

    def generate_fragments(self):
        fragments = []
        for predicate in self.predicates:
            fragments.append(predicate.split())
        return fragments

# Example usage:
predicates = ["age >= 18", "gender = 'male'", "height < 180"]
fragment_generator = HorizontalMinitermFragmentGenerator(predicates)
fragments = fragment_generator.generate_fragments()
print(fragments)
