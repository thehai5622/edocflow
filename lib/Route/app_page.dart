import 'package:edocflow/View/Document/detail_document.dart';
import 'package:edocflow/View/Document/document_in.dart';
import 'package:edocflow/View/Document/document_out.dart';
import 'package:edocflow/View/Document/upsert_document_out.dart';
import 'package:edocflow/View/Field/create_field.dart';
import 'package:edocflow/View/Field/edit_field.dart';
import 'package:edocflow/View/Field/field.dart';
import 'package:edocflow/View/Home/home.dart';
import 'package:edocflow/View/Individual/ChangePass/ChangePass.dart';
import 'package:edocflow/View/Individual/individual.dart';
import 'package:edocflow/View/IssuingAuthority/create_ia.dart';
import 'package:edocflow/View/IssuingAuthority/edit_ia.dart';
import 'package:edocflow/View/IssuingAuthority/issuingauthority.dart';
import 'package:edocflow/View/Login/login.dart';
import 'package:edocflow/View/Individual/Profile/profile.dart';
import 'package:edocflow/View/TemplateFile/detail_templatefile.dart';
import 'package:edocflow/View/TemplateFile/templatefile.dart';
import 'package:edocflow/View/TemplateFile/upsert_templatefile.dart';
import 'package:edocflow/View/TypeTemplateFile/create_ttf.dart';
import 'package:edocflow/View/TypeTemplateFile/edit_ttf.dart';
import 'package:edocflow/View/TypeTemplateFile/type_template_file.dart';
import 'package:edocflow/View/User/create_user.dart';
import 'package:edocflow/View/User/detail_user.dart';
import 'package:edocflow/View/User/user.dart';
import 'package:edocflow/View/dashboard.dart';
import 'package:edocflow/View/splash.dart';
import 'package:get/get.dart';

part 'app_route.dart';

class AppPage {
  AppPage._();

  static const String initialRoute = Routes.splash;

  static final List<GetPage<dynamic>> routes = [
    GetPage(name: Routes.dashboard, page: () => Dashboard()),
    GetPage(name: Routes.splash, page: () => Splash()),
    GetPage(name: Routes.home, page: () => Home()),
    GetPage(name: Routes.login, page: () => Login()),
    GetPage(name: Routes.field, page: () => Field()),
    GetPage(name: Routes.createField, page: () => CreateField()),
    GetPage(name: Routes.editField, page: () => EditField()),
    GetPage(name: Routes.typeTemplateFile, page: () => TypeTemplateFile()),
    GetPage(name: Routes.createTtf, page: () => CreateTypeTemplateFile()),
    GetPage(name: Routes.editTtf, page: () => EditTypeTemplateFile()),
    GetPage(name: Routes.issuingAuthority, page: () => IssuingAuthority()),
    GetPage(name: Routes.createIa, page: () => CreateIssuingAuthority()),
    GetPage(name: Routes.editIa, page: () => EditIssuingAuthority()),
    GetPage(name: Routes.individual, page: () => Individual()),
    GetPage(name: Routes.changePass, page: () => ChangePass()),
    GetPage(name: Routes.profile, page: () => Profile()),
    GetPage(name: Routes.templateFile, page: () => TemplateFile()),
    GetPage(name: Routes.upsertTemplateFile, page: () => UpsertTemplateFile()),
    GetPage(name: Routes.upsertTemplateFile, page: () => UpsertTemplateFile()),
    GetPage(name: Routes.detailTemplateFile, page: () => DetailTemplateFile()),
    GetPage(name: Routes.documentIn, page: () => DocumentIn()),
    GetPage(name: Routes.documentOut, page: () => DocumentOut()),
    GetPage(name: Routes.upsertDocumentOut, page: () => UpsertDocumentOut()),
    GetPage(name: Routes.detailDocument, page: () => DetailDocument()),
    GetPage(name: Routes.user, page: () => User()),
    GetPage(name: Routes.createUser, page: () => CreateUser()),
    GetPage(name: Routes.detailUser, page: () => DetailUser()),
  ];
}
