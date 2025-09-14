import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/get_characters/get_characters_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/pages/character_detail_page.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});
  static const routeName = '/';

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  late final GetCharactersBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<GetCharactersBloc>();
    _bloc.add(GetCharacters(page: 1));
  }

  void _navigateToCharacterDetail(CharactersEntity character, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterDetailPage(character: character),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildStatusIndicator(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text(
          'RICK AND MORTY',
          style: TextStyle(
            color: Color(0xFF00FF41),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF00FF41)),
      ),
      body: BlocBuilder<GetCharactersBloc, GetCharactersState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is GetCharactersLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00FF41)),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Wubba Lubba Dub Dub!',
                    style: TextStyle(
                      color: Color(0xFF00FF41),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is GetCharactersError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _bloc.add(GetCharacters(page: 1)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00FF41),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('TRY AGAIN'),
                  ),
                ],
              ),
            );
          }

          if (state is GetCharactersSuccess) {
            return Column(
              children: [
                
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${state.data.length} CHARACTERS',
                        style: const TextStyle(
                          color: Color(0xFF00FF41),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'PAGE ${state.currentPage}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          if (state.currentPage > 1)
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios, size: 20),
                              color: const Color(0xFF00FF41),
                              onPressed: () {
                                _bloc.add(GetCharacters(page: state.currentPage - 1));
                              },
                            ),
                          
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios, size: 20),
                              color: const Color(0xFF00FF41),
                              onPressed: () {
                                _bloc.add(GetCharacters(page: state.currentPage + 1));
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final character = state.data[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        color: const Color(0xFF1A1A1A),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: Colors.green.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: InkWell(
                          onTap: () => _navigateToCharacterDetail(character, context),
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                               
                                Hero(
                                  tag: 'character-${character.name}',
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: const Color(0xFF00FF41),
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.3),
                                          blurRadius: 8,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                        character.image,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded /
                                                      loadingProgress.expectedTotalBytes!
                                                  : null,
                                              color: const Color(0xFF00FF41),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),

                                // Informações do personagem
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        character.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        character.species,
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Status indicator
                                _buildStatusIndicator(character.status),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}