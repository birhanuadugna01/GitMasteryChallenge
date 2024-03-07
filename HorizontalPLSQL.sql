PLSQL
CREATE OR REPLACE TYPE fragment_type AS TABLE OF VARCHAR2(100);
	
CREATE OR REPLACE TYPE fragment_generator AS OBJECT (
    predicates fragment_type,
    CONSTRUCTOR FUNCTION fragment_generator RETURN SELF AS RESULT,
    MEMBER FUNCTION generate_fragments RETURN fragment_type
);

CREATE OR REPLACE TYPE BODY fragment_generator AS
    CONSTRUCTOR FUNCTION fragment_generator RETURN SELF AS RESULT IS
    BEGIN
        SELF.predicates := fragment_type();
        RETURN;
    END;

    MEMBER FUNCTION generate_fragments RETURN fragment_type IS
        fragments fragment_type := fragment_type();
    BEGIN
        FOR i IN 1..self.predicates.COUNT LOOP
            fragments.EXTEND;
            fragments(fragments.LAST) := self.predicates(i);
        END LOOP;
        RETURN fragments;
    END;
END;

-- Example usage:
DECLARE
    predicates fragment_type := fragment_type('age >= 18', 'gender = ''male''', 'height < 180');
    frag_gen fragment_generator := fragment_generator(predicates);
    fragments fragment_type;
BEGIN
    fragments := frag_gen.generate_fragments();
    FOR i IN 1..fragments.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(fragments(i));
    END LOOP;
END;


                                             
