template <typename Elem>
class Fila {
    private:
    public:
        Fila();
        ~Fila();
        int longLista() const;
        void agregarLista(int, Elem);
        void eliminarLista(int);
        Elem recuperarLista(int);
};
